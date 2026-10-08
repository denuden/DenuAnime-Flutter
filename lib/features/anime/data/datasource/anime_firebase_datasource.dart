import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denuanime/features/anime/data/request/favorite_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/exception/no_user_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnimeFirebaseDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AnimeFirebaseDatasource(this.firebaseFirestore, this.firebaseAuth);

  Future<void> addAnime(FavoriteAnimeRequest request) async {
    final currentUser = firebaseAuth.currentUser ?? (throw NoUserException());

    try {
      final favoritesCollection = "favorites";
      final usersCollection = "users";

      final todayTimeStamp = FieldValue.serverTimestamp();

      final docRef = firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(favoritesCollection)
          .doc((request.anime.mal_id ?? -1).toString());

      final anime = request.anime;

      await docRef
          .set({
            'mal_id': anime.mal_id,
            'title': anime.title_english ?? anime.title,
            'image_url': anime.images?.jpg?.large_image_url ?? '',
            'score': anime.score,
            'season': anime.season,
            'year': anime.year,
            'added_at': todayTimeStamp,
          })
          .timeout(const Duration(seconds: 10));
    } on TimeoutException {
      throw Exception("You're offline. It will be added once you're online");
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? "Failed to add favorite");
    } catch (e) {
      throw Exception("Something went wrong. ${e.toString()}");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAnimeList() {
    final currentUser = firebaseAuth.currentUser ?? (throw NoUserException());

    return firebaseFirestore
        .collection("users")
        .doc(currentUser.uid)
        .collection("favorites")
        .snapshots();
  }
}
