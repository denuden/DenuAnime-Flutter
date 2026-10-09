class FavoriteAnimeRequest {
  final int mal_id;
  final String title;
  final String image_url;
  final double score;
  final String season;
  final int year;

  final bool isFav;

  const FavoriteAnimeRequest({
    required this.mal_id,
    required this.title,
    required this.image_url,
    required this.score,
    required this.season,
    required this.year,
    required this.isFav,
  });
}
