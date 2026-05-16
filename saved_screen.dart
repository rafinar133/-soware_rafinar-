import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../models/soware_image.dart';
import '../services/storage_service.dart';
import '../widgets/image_card.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'image_detail_screen.dart';

class SavedScreen extends StatefulWidget {
  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final StorageService _storageService = StorageService();
  List<SowareImage> _savedImages = [];

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  void _loadSavedImages() {
    setState(() => _savedImages = _storageService.getSavedImages());
  }

  Future<void> _removeImage(String imageId) async {
    await _storageService.removeSavedImage(imageId);
    _loadSavedImages();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم الحذف', textDirection: TextDirection.rtl),
        backgroundColor: AppColors.terracotta,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBeige,
      body: CustomScrollView(
        slivers: [
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
                  Text(
                    'المحفوظات 📌',
                    style: AppTextStyles.headingLarge.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${_savedImages.length} صورة محفوظة',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
          ),

          if (_savedImages.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bookmark_border, size: 80,
                      color: AppColors.textMuted.withOpacity(0.5)),
                    SizedBox(height: 20),
                    Text('ما عندك حتى صورة محفوظة',
                      style: AppTextStyles.headingMedium),
                    SizedBox(height: 8),
                    Text('ابداي حفظ الصور اللي تعجبك',
                      style: AppTextStyles.bodyMedium),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.explore),
                      label: Text('استكشف صور'),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverMasonryGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childCount: _savedImages.length,
                itemBuilder: (context, index) {
                  final image = _savedImages[index];
                  return Dismissible(
                    key: Key(image.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      decoration: BoxDecoration(
                        color: AppColors.terracotta,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20),
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) => _removeImage(image.id),
                    child: ImageCard(
                      image: image.copyWith(isSaved: true),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ImageDetailScreen(image: image)),
                      ),
                      onSave: () => _removeImage(image.id),
                    ),
                  );
                },
              ),
            ),

          SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}
