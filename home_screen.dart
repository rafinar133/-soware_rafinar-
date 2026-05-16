import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/soware_image.dart';
import '../models/categories.dart';
import '../services/unsplash_service.dart';
import '../services/storage_service.dart';
import '../widgets/image_card.dart';
import '../widgets/category_chip.dart';
import '../widgets/shimmer_loading.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'image_detail_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UnsplashService _unsplashService = UnsplashService();
  final StorageService _storageService = StorageService();

  List<SowareImage> _images = [];
  List<SowareImage> _trendingImages = [];
  bool _isLoading = true;
  String _selectedCategory = 'all';
  int _currentPage = 1;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _loadImages();
    _loadTrending();
  }

  Future<void> _loadImages() async {
    setState(() => _isLoading = true);
    final images = await _unsplashService.getRandomImages(count: 20);
    setState(() {
      _images = images;
      _isLoading = false;
    });
  }

  Future<void> _loadTrending() async {
    final images = await _unsplashService.searchImages('trending', perPage: 10);
    setState(() => _trendingImages = images);
  }

  Future<void> _loadCategoryImages(String categoryId) async {
    setState(() => _isLoading = true);
    final category = categories.firstWhere((c) => c.id == categoryId);
    final images = await _unsplashService.searchImages(
      category.searchQuery, perPage: 20,
    );
    setState(() {
      _images = images;
      _isLoading = false;
    });
  }

  Future<void> _loadMoreImages() async {
    if (_isLoadingMore) return;
    setState(() => _isLoadingMore = true);

    _currentPage++;
    final newImages = await _unsplashService.getRandomImages(count: 20);

    setState(() {
      _images.addAll(newImages);
      _isLoadingMore = false;
    });
  }

  Future<void> _onLike(SowareImage image) async {
    await _storageService.toggleLike(image.id);
    setState(() {
      final index = _images.indexWhere((img) => img.id == image.id);
      if (index != -1) {
        _images[index] = _images[index].copyWith(
          isLiked: !_images[index].isLiked,
        );
      }
    });
  }

  Future<void> _onSave(SowareImage image) async {
    if (image.isSaved) {
      await _storageService.removeSavedImage(image.id);
    } else {
      await _storageService.saveImage(image);
    }
    setState(() {
      final index = _images.indexWhere((img) => img.id == image.id);
      if (index != -1) {
        _images[index] = _images[index].copyWith(
          isSaved: !_images[index].isSaved,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBeige,
      body: RefreshIndicator(
        onRefresh: _loadImages,
        color: AppColors.sageGreen,
        backgroundColor: AppColors.cream,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.sageGreen, AppColors.sageDark],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Soware Rafinar',
                              style: AppTextStyles.headingLarge.copyWith(
                                color: Colors.white, fontSize: 28,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'صور منتقاة بعناية 🌿',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: Colors.white, size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context, MaterialPageRoute(builder: (_) => SearchScreen()),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.white.withOpacity(0.3)),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.white.withOpacity(0.8)),
                            SizedBox(width: 12),
                            Text(
                              'قلب على صور...',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Categories
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 20, left: 16, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('التصنيفات', style: AppTextStyles.headingSmall),
                    SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length + 1,
                        padding: EdgeInsets.only(right: 16),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Padding(
                              padding: EdgeInsets.only(right: 8),
                              child: CategoryChip(
                                category: Category(
                                  id: 'all', name: 'All', nameAr: 'الكل',
                                  icon: Icons.apps,
                                  color: AppColors.sageGreen,
                                  searchQuery: 'random',
                                ),
                                isSelected: _selectedCategory == 'all',
                                onTap: () {
                                  setState(() => _selectedCategory = 'all');
                                  _loadImages();
                                },
                              ),
                            );
                          }
                          final category = categories[index - 1];
                          return Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: CategoryChip(
                              category: category,
                              isSelected: _selectedCategory == category.id,
                              onTap: () {
                                setState(() => _selectedCategory = category.id);
                                _loadCategoryImages(category.id);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Trending
            if (_trendingImages.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('الأكثر زيارة 🔥', style: AppTextStyles.headingSmall),
                          TextButton(
                            onPressed: () {},
                            child: Text('شوف الكل'),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _trendingImages.length,
                          itemBuilder: (context, index) {
                            final image = _trendingImages[index];
                            return GestureDetector(
                              onTap: () => _openImageDetail(image),
                              child: Container(
                                width: 140,
                                margin: EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.shadow,
                                      blurRadius: 8, offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    image.thumbUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (ctx, child, progress) {
                                      if (progress == null) return child;
                                      return Container(
                                        color: AppColors.sageLight,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            color: AppColors.sageGreen,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            // Main Grid Header
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('اكتشف صور جديدة', style: AppTextStyles.headingSmall),
              ),
            ),

            // Grid
            if (_isLoading)
              SliverToBoxAdapter(
                child: SizedBox(height: 400, child: GridShimmer()),
              )
            else
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverMasonryGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childCount: _images.length,
                  itemBuilder: (context, index) {
                    final image = _images[index];
                    return ImageCard(
                      image: image,
                      onTap: () => _openImageDetail(image),
                      onLike: () => _onLike(image),
                      onSave: () => _onSave(image),
                    );
                  },
                ),
              ),

            // Load More
            if (_isLoadingMore)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.sageGreen),
                  ),
                ),
              )
            else if (_images.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: ElevatedButton.icon(
                    onPressed: _loadMoreImages,
                    icon: Icon(Icons.refresh),
                    label: Text('زيد صور'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.sageGreen,
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ),

            SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
    );
  }

  void _openImageDetail(SowareImage image) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ImageDetailScreen(image: image)),
    );
  }
}
