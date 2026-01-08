import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/category.dart';
import '../../domain/repositories/category_repository.dart';
import '../mappers/category_mapper.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepositoryImpl(this._firestore);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      final models = snapshot.docs
          .map((doc) => CategoryModel.fromJson({
            ...doc.data(),
            'id': doc.id,
          }))
          .toList();
      return models.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to load categories: \$e');
    }
  }

  @override
  Stream<List<Category>> getCategoriesStream() {
    try {
      return _firestore.collection('categories').snapshots().map((snapshot) {
        final models = snapshot.docs
            .map((doc) => CategoryModel.fromJson(doc.data()..['id'] = doc.id))
            .toList();
        return models.map((model) => model.toEntity()).toList();
      });
    } catch (e) {
      throw Exception('Failed to load categories: \$e');
    }
  }
}
