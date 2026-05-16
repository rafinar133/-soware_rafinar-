import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/soware_image.dart';

class UnsplashService {
  // Using Unsplash Source API (free, no key required for demo)
  // For production, get API key from unsplash.com/developers
  static const String _baseUrl = 'https://api.unsplash.com';
  static const String _accessKey = 'YOUR_UNSPLASH_API_KEY'; // Replace with real key

  // Demo mode - using picsum or placeholder for testing
  static const String _demoUrl = 'https://picsum.photos';

  Future<List<SowareImage>> searchImages(String query, {int page = 1, int perPage = 20}) async {
    try {
      // For demo without API key, we'll use a mock approach
      // In production, use: $_baseUrl/search/photos?query=$query&page=$page&per_page=$perPage&client_id=$_accessKey

      final response = await http.get(
        Uri.parse('$_demoUrl/v2/list?page=$page&limit=$perPage'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => _convertToSowareImage(json, query)).toList();
      } else {
        // Fallback to mock data
        return _getMockImages(query);
      }
    } catch (e) {
      return _getMockImages(query);
    }
  }

  Future<List<SowareImage>> getRandomImages({int count = 20}) async {
    return searchImages('random', perPage: count);
  }

  SowareImage _convertToSowareImage(Map<String, dynamic> json, String category) {
    final id = json['id'].toString();
    return SowareImage(
      id: 'unsplash_$id',
      url: json['download_url'] ?? 'https://picsum.photos/800/600?random=$id',
      thumbUrl: json['download_url'] ?? 'https://picsum.photos/400/300?random=$id',
      title: json['author'] != null ? 'صورة من ${json['author']}' : 'صورة جميلة',
      category: category,
      photographer: json['author'] ?? 'مصور مجهول',
      width: json['width'] ?? 800,
      height: json['height'] ?? 600,
    );
  }

  List<SowareImage> _getMockImages(String category) {
    // Generate mock images with consistent IDs
    final List<SowareImage> images = [];
    final List<String> photographers = [
      'أحمد الفاسي', 'ليلى المراكشية', 'يوسف الرباطي',
      'فاطمة الزهراء', 'عبدالله الصويري', 'نور الدين',
    ];

    for (int i = 0; i < 20; i++) {
      final seed = '${category}_$i';
      images.add(SowareImage(
        id: 'mock_${seed.hashCode}',
        url: 'https://picsum.photos/seed/$seed/800/600',
        thumbUrl: 'https://picsum.photos/seed/$seed/400/300',
        title: 'صورة $category رائعة',
        category: category,
        photographer: photographers[i % photographers.length],
        width: 800,
        height: 600,
      ));
    }
    return images;
  }
}
