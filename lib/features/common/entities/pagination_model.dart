class PaginationModel {
  final int? last_visible_page;
  final bool? has_next_page;
  final int? current_page;
  final Items? items;

  const PaginationModel({
    this.last_visible_page,
    this.has_next_page,
    this.current_page,
    this.items,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      last_visible_page: json['last_visible_page'] as int?,
      has_next_page: json['has_next_page'] as bool?,
      current_page: json['current_page'] as int?,
      items: json['items'] != null
          ? Items.fromJson(json['items'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_visible_page': last_visible_page,
      'has_next_page': has_next_page,
      'current_page': current_page,
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
