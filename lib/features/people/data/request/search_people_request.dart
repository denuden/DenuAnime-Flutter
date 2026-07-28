class SearchPeopleRequest {
  final String? q; //query
  final String? page; //min 1
  final String? limit; //min1 max 50
  final String? order_by; //mal_id, name. birthday, favorites
  final String? sort; //asc, desc
  final String? letter; //one letter

  const SearchPeopleRequest({
    this.q,
    this.page,
    this.limit,
    this.order_by,
    this.sort,
    this.letter,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      if (q != null) "q": q,
      if (page != null) "page": page,
      if (limit != null) "limit": limit,
      if (order_by != null) "order_by": order_by,
      if (sort != null) "sort": sort,
      if (letter != null) "letter": letter,
    };
  }
}
