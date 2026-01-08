/// Category entity representing a video generation category
class Category {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final int sortOrder;

  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.sortOrder,
  });

  Category copyWith({
    String? id,
    String? name,
    String? description,
    String? iconUrl,
    int? sortOrder,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconUrl: iconUrl ?? this.iconUrl,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        runtimeType == other.runtimeType &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        iconUrl == other.iconUrl &&
        sortOrder == other.sortOrder;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        iconUrl.hashCode ^
        sortOrder.hashCode;
  }
}
