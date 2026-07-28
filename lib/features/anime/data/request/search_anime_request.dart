class SearchAnimeRequest {
  final String? q; //title search
  final String? page; //min 1 max 1000
  final String? limit; // min 1 max 50
  final String? type; // tv, movie, ova, special, ona, music, cm, pv, tv_special
  final String? status; //airing, complete, upcoming
  final String? rating; //g, pg, pg13, rx17, r, rx
  final String? sfw; // true, false
  final String? sfw_strict; //true, false
  final String? unapproved; //true, false
  final String? score; // min 1 max 9.99
  final String? min_score; //min 0 max 10
  final String? max_score; // min 1 max 10
  final String? genres; // comma separated id's of genre endpoint
  final String? genres_exclude; // comma separated id's of genre endpoint
  final String? order_by; // mal_id, title, start_date, end_date, episodes
  final String? sort; //asc, desc
  final String? letter; //one letter
  final String? producers; //comma sepearated id's
  final String? start_date; // 2017-07-21 yyyy-MM-dd
  final String? end_date; // 2017-07-21 yyyy-MM-dd

  const SearchAnimeRequest({
    this.q,
    this.page,
    this.limit,
    this.type,
    this.status,
    this.rating,
    this.sfw,
    this.sfw_strict,
    this.unapproved,
    this.score,
    this.min_score,
    this.max_score,
    this.genres,
    this.genres_exclude,
    this.order_by,
    this.sort,
    this.letter,
    this.producers,
    this.start_date,
    this.end_date,
  });
}
