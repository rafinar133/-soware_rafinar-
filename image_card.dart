import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/soware_image.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ImageCard extends StatelessWidget {
  final SowareImage image;
  final VoidCallback? onTap;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onDownload;
  final bool showActions;

  const ImageCard({
    Key? key,
    required this.image,
    this.onTap,
    this.onLike,
    this.onSave,
    this.onDownload,
    this.showActions = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cream,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              AspectRatio(
                aspectRatio: image.width / image.height,
                child: CachedNetworkImage(
                  imageUrl: image.thumbUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.sageLight,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.sageGreen,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.cardBeige,
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.textMuted,
                      size: 40,
                    ),
                  ),
                ),
              ),

              // Info
              if (showActions) ...[
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        image.title,
                        style: AppTextStyles.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 14,
                            color: AppColors.textMuted,
                          ),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              image.photographer,
                              style: AppTextStyles.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      // Action buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: image.isLiked 
                              ? Icons.favorite 
                              : Icons.favorite_border,
                            color: image.isLiked 
                              ? AppColors.terracotta 
                              : AppColors.textMuted,
                            onTap: onLike,
                          ),
                          _buildActionButton(
                            icon: image.isSaved 
                              ? Icons.bookmark 
                              : Icons.bookmark_border,
                            color: image.isSaved 
                              ? AppColors.sageGreen 
                              : AppColors.textMuted,
                            onTap: onSave,
                          ),
                          _buildActionButton(
                            icon: Icons.download_outlined,
                            color: AppColors.textMuted,
                            onTap: onDownload,
                          ),
                          _buildActionButton(
                            icon: Icons.share_outlined,
                            color: AppColors.textMuted,
                            onTap: () {
                              // Share functionality
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Icon(
          icon,
          color: color,
          size: 22,
        ),
      ),
    );
  }
}
