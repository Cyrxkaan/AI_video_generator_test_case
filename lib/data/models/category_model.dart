import '../../domain/entities/category.dart';

/// Model class for category data from Firestore
class CategoryModel {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final int sortOrder;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.sortOrder,
  });

  /// Converts [CategoryModel] to [Category]
  Category toEntity() {
    return Category(
      id: id,
      name: name,
      description: description,
      iconUrl: iconUrl,
      sortOrder: sortOrder,
    );
  }

  /// Creates a [CategoryModel] from a [Category] entity
  CategoryModel fromEntity(Category category) {
    return CategoryModel(
      id: category.id,
      name: category.name,
      description: category.description,
      iconUrl: category.iconUrl,
      sortOrder: category.sortOrder,
    );
  }

  /// Creates a [CategoryModel] from a JSON map
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      sortOrder: json['sortOrder'] as int,
    );
  }

  /// Converts this model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconUrl': iconUrl,
      'sortOrder': sortOrder,
    };
  }
}

