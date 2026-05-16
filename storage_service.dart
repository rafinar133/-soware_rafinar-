import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/soware_image.dart';
import '../models/board.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Saved Images
  Future<void> saveImage(SowareImage image) async {
    final savedImages = getSavedImages();
    if (!savedImages.any((img) => img.id == image.id)) {
      savedImages.add(image.copyWith(isSaved: true, savedAt: DateTime.now()));
      await _saveImagesList(savedImages);
    }
  }

  Future<void> removeSavedImage(String imageId) async {
    final savedImages = getSavedImages();
    savedImages.removeWhere((img) => img.id == imageId);
    await _saveImagesList(savedImages);
  }

  List<SowareImage> getSavedImages() {
    final String? data = _prefs.getString('saved_images');
    if (data == null) return [];
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => SowareImage.fromJson(json)).toList();
  }

  Future<void> _saveImagesList(List<SowareImage> images) async {
    final String data = jsonEncode(images.map((img) => img.toJson()).toList());
    await _prefs.setString('saved_images', data);
  }

  bool isImageSaved(String imageId) {
    return getSavedImages().any((img) => img.id == imageId);
  }

  // Liked Images
  Future<void> toggleLike(String imageId) async {
    final likedImages = getLikedImages();
    if (likedImages.contains(imageId)) {
      likedImages.remove(imageId);
    } else {
      likedImages.add(imageId);
    }
    await _prefs.setStringList('liked_images', likedImages);
  }

  List<String> getLikedImages() {
    return _prefs.getStringList('liked_images') ?? [];
  }

  bool isImageLiked(String imageId) {
    return getLikedImages().contains(imageId);
  }

  // Boards
  Future<void> createBoard(Board board) async {
    final boards = getBoards();
    boards.add(board);
    await _saveBoardsList(boards);
  }

  Future<void> updateBoard(Board board) async {
    final boards = getBoards();
    final index = boards.indexWhere((b) => b.id == board.id);
    if (index != -1) {
      boards[index] = board;
      await _saveBoardsList(boards);
    }
  }

  Future<void> deleteBoard(String boardId) async {
    final boards = getBoards();
    boards.removeWhere((b) => b.id == boardId);
    await _saveBoardsList(boards);
  }

  Future<void> addImageToBoard(String boardId, SowareImage image) async {
    final boards = getBoards();
    final index = boards.indexWhere((b) => b.id == boardId);
    if (index != -1) {
      final board = boards[index];
      if (!board.images.any((img) => img.id == image.id)) {
        final updatedImages = [...board.images, image];
        boards[index] = board.copyWith(
          images: updatedImages,
          coverImage: board.coverImage.isEmpty ? image.thumbUrl : board.coverImage,
        );
        await _saveBoardsList(boards);
      }
    }
  }

  Future<void> removeImageFromBoard(String boardId, String imageId) async {
    final boards = getBoards();
    final index = boards.indexWhere((b) => b.id == boardId);
    if (index != -1) {
      final board = boards[index];
      final updatedImages = board.images.where((img) => img.id != imageId).toList();
      boards[index] = board.copyWith(
        images: updatedImages,
        coverImage: updatedImages.isNotEmpty ? updatedImages.first.thumbUrl : '',
      );
      await _saveBoardsList(boards);
    }
  }

  List<Board> getBoards() {
    final String? data = _prefs.getString('boards');
    if (data == null) return [];
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => Board.fromJson(json)).toList();
  }

  Future<void> _saveBoardsList(List<Board> boards) async {
    final String data = jsonEncode(boards.map((b) => b.toJson()).toList());
    await _prefs.setString('boards', data);
  }

  // Download image to local storage
  Future<String?> downloadImage(String url, String filename) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageDir = Directory('${directory.path}/soware_images');
      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      final filePath = '${imageDir.path}/$filename.jpg';
      final file = File(filePath);

      // In real app, download from URL
      // For now, return the path
      return filePath;
    } catch (e) {
      return null;
    }
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs.remove('saved_images');
    await _prefs.remove('liked_images');
    await _prefs.remove('boards');
  }
}
