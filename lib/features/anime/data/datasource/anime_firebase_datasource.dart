import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denuanime/features/anime/data/request/favorite_anime_request.dart';
import 'package:denuanime/features/anime/domain/entities/exception/add_favorite_exception.dart';
import 'package:denuanime/features/anime/domain/entities/exception/no_user_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AnimeFirebaseDatasource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AnimeFirebaseDatasource(this.firebaseFirestore, this.firebaseAuth);

  Future<void> toggleFavorite(FavoriteAnimeRequest request) async {
    final currentUser = firebaseAuth.currentUser ?? (throw NoUserException());

    try {
      final favoritesCollection = "favorites";
      final usersCollection = "users";

      final todayTimeStamp = FieldValue.serverTimestamp();

      final docRef = firebaseFirestore
          .collection(usersCollection)
          .doc(currentUser.uid)
          .collection(favoritesCollection)
          .doc((request.mal_id).toString());

      if (request.isFav) {
        //means i clicked the button. so if true -> click - goes false -> then should delete
        await docRef.delete().timeout(const Duration(seconds: 10));
      } else {
        await docRef
            .set({
              'mal_id': request.mal_id,
              'title': request.title,
              'image_url': request.image_url,
              'score': request.score,
              'season': request.season,
              'year': request.year,
              'added_at': todayTimeStamp,
            })
            .timeout(const Duration(seconds: 10));
      }
    } on TimeoutException {
      throw Exception("You're offline. It will be added once you're online");
    } on FirebaseException catch (e) {
      throw Exception(e.message ?? "Failed to add favorite");
    } catch (e) {
      throw FavoriteException("Something went wrong. $e");
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
