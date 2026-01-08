import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../models/category_model.dart' as models;

class CategoryRepositoryImpl implements CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepositoryImpl(this._firestore);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      final categoryModels = snapshot.docs
          .map((doc) => models.CategoryModel.fromJson({
            ...doc.data(),
            'id': doc.id,
          }))
          .toList();
      return categoryModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load categories: \$e');
    }
  }

  @override
  Stream<List<Category>> getCategoriesStream() {
    try {
      return _firestore.collection('categories').snapshots().map((snapshot) {
        final categoryModels = snapshot.docs
            .map((doc) => models.CategoryModel.fromJson({
              ...doc.data(),
              'id': doc.id,
            }))
            .toList();
        return categoryModels.map((model) => model.toEntity()).toList();
      });
    } catch (e) {
      throw Exception('Failed to load categories: \$e');
    }
  }
}
