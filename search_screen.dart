import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/soware_image.dart';
import '../services/unsplash_service.dart';
import '../services/storage_service.dart';
import '../widgets/image_card.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'image_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final UnsplashService _unsplashService = UnsplashService();
  final StorageService _storageService = StorageService();
  final TextEditingController _searchController = TextEditingController();

  List<SowareImage> _searchResults = [];
  bool _isLoading = false;
  bool _hasSearched = false;

  final List<String> _recentSearches = [
    'طبيعة', 'ديكور', 'طبخ مغربي', 'أزياء تقليدية',
  ];

  Future<void> _search(String query) async {
    if (query.isEmpty) return;
    setState(() { _isLoading = true; _hasSearched = true; });

    final results = await _unsplashService.searchImages(query, perPage: 30);
    setState(() { _searchResults = results; _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBeige,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.sageGreen, AppColors.sageDark],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white.withOpacity(0.3)),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: TextStyle(color: Colors.white),
                            textDirection: TextDirection.rtl,
                            decoration: InputDecoration(
                              hintText: 'قلب على صور...',
                              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search, color: Colors.white.withOpacity(0.8)),
                                onPressed: () => _search(_searchController.text),
                              ),
                            ),
                            onSubmitted: _search,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: _hasSearched ? _buildSearchResults() : _buildRecentSearches(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('بحوث سابقة', style: AppTextStyles.headingSmall),
          SizedBox(height: 16),
          Wrap(
            spacing: 10, runSpacing: 10,
            children: _recentSearches.map((search) {
              return GestureDetector(
                onTap: () {
                  _searchController.text = search;
                  _search(search);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: AppColors.divider),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.history, size: 16, color: AppColors.textMuted),
                      SizedBox(width: 8),
                      Text(search, style: AppTextStyles.bodyMedium),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 30),
          Text('اقتراحات', style: AppTextStyles.headingSmall),
          SizedBox(height: 16),
          _buildSuggestion('🌿 صور الطبيعة المغربية'),
          _buildSuggestion('🏠 ديكورات بيوت تقليدية'),
          _buildSuggestion('🍲 أطباق مغربية شهية'),
          _buildSuggestion('👗 أزياء مغربية أصيلة'),
        ],
      ),
    );
  }

  Widget _buildSuggestion(String text) {
    return GestureDetector(
      onTap: () {
        _searchController.text = text.replaceAll(RegExp(r'[^\w\s]'), '').trim();
        _search(_searchController.text);
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.cream,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              Icon(Icons.trending_up, color: AppColors.terracotta, size: 20),
              SizedBox(width: 12),
              Text(text, style: AppTextStyles.bodyLarge),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator(color: AppColors.sageGreen));
    }
    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textMuted),
            SizedBox(height: 16),
            Text('ما لقيناش صور', style: AppTextStyles.headingMedium),
            SizedBox(height: 8),
            Text('جرب كلمة أخرى', style: AppTextStyles.bodyMedium),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.all(16),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final image = _searchResults[index];
          return ImageCard(
            image: image,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ImageDetailScreen(image: image)),
            ),
          );
        },
      ),
    );
  }
}
