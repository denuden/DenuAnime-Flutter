class PaginatedResultModel<T> {
  final List<T> items;
  final int currentPage;
  final bool hasNextPage;

  const PaginatedResultModel({
    required this.items,
    required this.currentPage,
    required this.hasNextPage,
  });
}
