import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import '../models/soware_image.dart';
import '../services/storage_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'boards_screen.dart';

class ImageDetailScreen extends StatefulWidget {
  final SowareImage image;
  const ImageDetailScreen({Key? key, required this.image}) : super(key: key);

  @override
  _ImageDetailScreenState createState() => _ImageDetailScreenState();
}

class _ImageDetailScreenState extends State<ImageDetailScreen> {
  final StorageService _storageService = StorageService();
  late SowareImage _image;
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
    _checkStatus();
  }

  void _checkStatus() {
    setState(() {
      _isLiked = _storageService.isImageLiked(_image.id);
      _isSaved = _storageService.isImageSaved(_image.id);
    });
  }

  Future<void> _toggleLike() async {
    await _storageService.toggleLike(_image.id);
    setState(() {
      _isLiked = !_isLiked;
      _image = _image.copyWith(isLiked: _isLiked);
    });
  }

  Future<void> _toggleSave() async {
    if (_isSaved) {
      await _storageService.removeSavedImage(_image.id);
    } else {
      await _storageService.saveImage(_image);
    }
    setState(() {
      _isSaved = !_isSaved;
      _image = _image.copyWith(isSaved: _isSaved);
    });
  }

  void _shareImage() {
    Share.share('شوف هاد الصورة الزوينة من Soware Rafinar! 🌿\n${_image.url}');
  }

  void _addToBoard() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 20),
            Text('حفظ في لوحة', style: AppTextStyles.headingMedium),
            SizedBox(height: 20),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.sageLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.add, color: AppColors.sageGreen),
              ),
              title: Text('لوحة جديدة', style: AppTextStyles.bodyLarge),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => BoardsScreen()));
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBeige,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            backgroundColor: AppColors.sageGreen,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'image_${_image.id}',
                child: CachedNetworkImage(
                  imageUrl: _image.url,
                  fit: BoxFit.cover,
                  placeholder: (ctx, url) => Container(
                    color: AppColors.sageLight,
                    child: Center(child: CircularProgressIndicator(color: AppColors.sageGreen)),
                  ),
                ),
              ),
            ),
            leading: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_image.title, style: AppTextStyles.headingMedium),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.sageLight.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.camera_alt_outlined, size: 16, color: AppColors.sageGreen),
                      ),
                      SizedBox(width: 10),
                      Text(_image.photographer,
                        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.mutedBlue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _image.category,
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.mutedBlue, fontWeight: FontWeight.w600),
                    ),
                  ),

                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                        label: _isLiked ? 'معجب' : 'إعجاب',
                        color: _isLiked ? AppColors.terracotta : AppColors.textSecondary,
                        onTap: _toggleLike,
                      ),
                      _buildActionButton(
                        icon: _isSaved ? Icons.bookmark : Icons.bookmark_border,
                        label: _isSaved ? 'محفوظ' : 'حفظ',
                        color: _isSaved ? AppColors.sageGreen : AppColors.textSecondary,
                        onTap: _toggleSave,
                      ),
                      _buildActionButton(
                        icon: Icons.folder_outlined,
                        label: 'لوحة',
                        color: AppColors.textSecondary,
                        onTap: _addToBoard,
                      ),
                      _buildActionButton(
                        icon: Icons.share_outlined,
                        label: 'مشاركة',
                        color: AppColors.textSecondary,
                        onTap: _shareImage,
                      ),
                      _buildActionButton(
                        icon: Icons.download_outlined,
                        label: 'تحميل',
                        color: AppColors.textSecondary,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('جاري التحميل...', textDirection: TextDirection.rtl),
                              backgroundColor: AppColors.sageGreen,
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 24),
                  Divider(color: AppColors.divider),
                  SizedBox(height: 16),
                  Text('صور مشابهة', style: AppTextStyles.headingSmall),
                  SizedBox(height: 12),
                  Text('غادي تجي هنا صور مشابهة...', style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 6),
          Text(label, style: AppTextStyles.caption.copyWith(color: color)),
        ],
      ),
    );
  }
}
