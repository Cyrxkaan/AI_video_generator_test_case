import '../../domain/entities/category.dart';
import '../models/category_model.dart';

class CategoryMapper {
  static CategoryModel toModel(Category entity) {
    return CategoryModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      iconUrl: entity.iconUrl,
      sortOrder: entity.sortOrder,
    );
  }

  static Category toEntity(CategoryModel model) {
    return Category(
      id: model.id,
      name: model.name,
      description: model.description,
      iconUrl: model.iconUrl,
      sortOrder: model.sortOrder,
    );
  }

  static List<Category> toEntityList(List<CategoryModel> models) {
    return models.map(toEntity).toList();
  }

  static List<CategoryModel> toModelList(List<Category> entities) {
    return entities.map(toModel).toList();
  }
}
