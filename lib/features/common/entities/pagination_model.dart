class PaginationModel {
  final int? lastVisiblePage;
  final bool? hasNextPage;
  final int? currentPage;
  final Items? items;

  const PaginationModel({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      lastVisiblePage: json['last_visible_page'] as int?,
      hasNextPage: json['has_next_page'] as bool?,
      currentPage: json['current_page'] as int?,
      items: json['items'] != null ? Items.fromJson(json['items']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_visible_page': lastVisiblePage,
      'has_next_page': hasNextPage,
      'current_page': currentPage,
      'items': items?.toJson(),
    };
  }
}

class Items {
  final int? count;
  final int? total;
  final int? perPage;

  const Items({this.count, this.total, this.perPage});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      count: json['count'] as int?,
      total: json['total'] as int?,
      perPage: json['per_page'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'total': total, 'per_page': perPage};
  }
}
