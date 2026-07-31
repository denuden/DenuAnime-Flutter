class GetRecommendationsRequest {
  final String? page;
  final String? limit;
  final String? sfw;
  final String? sfw_strict;

  const GetRecommendationsRequest({
    this.page,
    this.limit,
    this.sfw,
    this.sfw_strict,
  });

  Map<String, dynamic> toQueryParameters() {
    return {
      if (page != null) 'page': page,
      if (limit != null) 'limit': limit,
      if (sfw != null) 'sfw': sfw,
      if (sfw_strict != null) 'sfw-strict': sfw_strict,
    };
  }
}
