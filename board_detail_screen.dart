import 'package:flutter/material.dart';
import '../models/board.dart';
import '../models/soware_image.dart';
import '../services/storage_service.dart';
import '../widgets/image_card.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'image_detail_screen.dart';

class BoardDetailScreen extends StatefulWidget {
  final Board board;
  const BoardDetailScreen({Key? key, required this.board}) : super(key: key);

  @override
  _BoardDetailScreenState createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends State<BoardDetailScreen> {
  final StorageService _storageService = StorageService();
  late Board _board;

  @override
  void initState() {
    super.initState();
    _board = widget.board;
  }

  Future<void> _removeImage(String imageId) async {
    await _storageService.removeImageFromBoard(_board.id, imageId);
    setState(() {
      _board = _board.copyWith(
        images: _board.images.where((img) => img.id != imageId).toList(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBeige,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.sageGreen,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _board.name,
                style: AppTextStyles.headingSmall.copyWith(color: Colors.white),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.sageGreen, AppColors.sageDark],
                  ),
                ),
                child: _board.coverImage.isNotEmpty
                  ? Image.network(
                      _board.coverImage,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.3),
                      colorBlendMode: BlendMode.darken,
                    )
                  : Center(
                      child: Icon(
                        Icons.folder_open,
                        size: 80,
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_board.description.isNotEmpty) ...[
                    Text(_board.description, style: AppTextStyles.bodyMedium),
                    SizedBox(height: 12),
                  ],
                  Row(
                    children: [
                      Icon(Icons.image_outlined, size: 18, color: AppColors.textMuted),
                      SizedBox(width: 8),
                      Text('${_board.imageCount} صورة', style: AppTextStyles.bodyMedium),
                      SizedBox(width: 20),
                      Icon(Icons.calendar_today_outlined, size: 18, color: AppColors.textMuted),
                      SizedBox(width: 8),
                      Text(
                        '${_board.createdAt.day}/${_board.createdAt.month}/${_board.createdAt.year}',
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (_board.images.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported_outlined, size: 64,
                      color: AppColors.textMuted.withOpacity(0.5)),
                    SizedBox(height: 16),
                    Text('ما عندك حتى صورة فهاد اللوحة',
                      style: AppTextStyles.headingMedium),
                    SizedBox(height: 8),
                    Text('زيد صور من المحفوظات', style: AppTextStyles.bodyMedium),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final image = _board.images[index];
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
                        image: image,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ImageDetailScreen(image: image)),
                        ),
                      ),
                    );
                  },
                  childCount: _board.images.length,
                ),
              ),
            ),

          SliverPadding(padding: EdgeInsets.only(bottom: 50)),
        ],
      ),
    );
  }
}
