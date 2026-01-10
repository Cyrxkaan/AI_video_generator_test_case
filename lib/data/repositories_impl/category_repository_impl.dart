import 'package:ai_vid_gen/data/mappers/category_mapper.dart';
import 'package:ai_vid_gen/data/models/category_model.dart';
import 'package:ai_vid_gen/domain/entities/category.dart';
import 'package:ai_vid_gen/domain/repositories/category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final FirebaseFirestore _firestore;

  CategoryRepositoryImpl(this._firestore);

  @override
  Future<List<Category>> getCategories() async {
    try {
      final snapshot = await _firestore.collection('categories').get();
      final categories = <Category>[];
      
      for (final doc in snapshot.docs) {
        try {
          // Create a new map with doc.id included
          final docData = Map<String, dynamic>.from(doc.data());
          docData['id'] = doc.id;
          
          // Ensure all required fields exist with default values if missing
          docData['name'] ??= 'Unnamed Category';
          docData['description'] ??= 'No description';
          docData['iconUrl'] ??= '';
          docData['sortOrder'] ??= 0;
          
          final categoryModel = CategoryModel.fromJson(docData);
          final category = CategoryMapper.toEntity(categoryModel);
          
          categories.add(category);
        } catch (e) {
          print('Error parsing category document ${doc.id}: $e');
          // Continue with other documents even if one fails
        }
      }
      
      return categories;
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  @override
  Stream<List<Category>> getCategoriesStream() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      final categories = <Category>[];
      
      for (final doc in snapshot.docs) {
        try {
          // Create a new map with doc.id included
          final docData = Map<String, dynamic>.from(doc.data());
          docData['id'] = doc.id;
          
          // Ensure all required fields exist with default values if missing
          docData['name'] ??= 'Unnamed Category';
          docData['description'] ??= 'No description';
          docData['iconUrl'] ??= '';
          docData['sortOrder'] ??= 0;
          
          final categoryModel = CategoryModel.fromJson(docData);
          final category = CategoryMapper.toEntity(categoryModel);
          
          categories.add(category);
        } catch (e) {
          print('Error parsing category document ${doc.id}: $e');
          // Continue with other documents even if one fails
        }
      }
      
      return categories;
    });
  }
}