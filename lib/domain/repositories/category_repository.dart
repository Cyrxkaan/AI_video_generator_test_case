import '../entities/category.dart';

abstract class CategoryRepository {
  /// Fetches all categories from Firestore
  Future<List<Category>> getCategories();

  /// Stream of categories from Firestore
  Stream<List<Category>> getCategoriesStream();
}
