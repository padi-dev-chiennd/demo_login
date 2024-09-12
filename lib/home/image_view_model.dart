import 'package:flutter/material.dart';
import 'package:demologin/database/database_helper.dart';
import 'package:demologin/home/image_model.dart';

class ImageViewModel extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<ImageModel> _images = [];

  List<ImageModel> get images => _images;

  Future<void> loadImages() async {
    _images = await _dbHelper.getImages();
    notifyListeners();
  }

  Future<void> addImage(ImageModel imageModel) async {
    await _dbHelper.insertImage(imageModel);
    _images.add(imageModel);
    notifyListeners();
  }
  Future<void> deleteImage(ImageModel imageModel) async {
    await _dbHelper.deleteImage(imageModel);
    _images.remove(imageModel);
    notifyListeners();
  }
  Future<void>editNameImage(ImageModel imageModel) async {
    await _dbHelper.editNameImage(imageModel);
    notifyListeners();
  }
}
