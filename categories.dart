import '../utils/app_colors.dart';
import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final String nameAr;
  final IconData icon;
  final Color color;
  final String searchQuery;

  Category({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.icon,
    required this.color,
    required this.searchQuery,
  });
}

final List<Category> categories = [
  Category(
    id: 'nature',
    name: 'Nature',
    nameAr: 'الطبيعة',
    icon: Icons.forest_outlined,
    color: AppColors.sageGreen,
    searchQuery: 'nature landscape forest mountain',
  ),
  Category(
    id: 'art',
    name: 'Art',
    nameAr: 'الفن',
    icon: Icons.palette_outlined,
    color: AppColors.terracotta,
    searchQuery: 'art painting abstract creative',
  ),
  Category(
    id: 'cooking',
    name: 'Cooking',
    nameAr: 'الطبخ',
    icon: Icons.restaurant_outlined,
    color: AppColors.mutedBlue,
    searchQuery: 'food cooking recipe delicious',
  ),
  Category(
    id: 'decor',
    name: 'Decor',
    nameAr: 'الديكور',
    icon: Icons.chair_outlined,
    color: AppColors.sageDark,
    searchQuery: 'interior design home decor',
  ),
  Category(
    id: 'fashion',
    name: 'Fashion',
    nameAr: 'الأزياء',
    icon: Icons.checkroom_outlined,
    color: AppColors.terracottaLight,
    searchQuery: 'fashion style outfit clothing',
  ),
  Category(
    id: 'travel',
    name: 'Travel',
    nameAr: 'السفر',
    icon: Icons.flight_takeoff_outlined,
    color: AppColors.mutedBlueLight,
    searchQuery: 'travel adventure destination',
  ),
  Category(
    id: 'sports',
    name: 'Sports',
    nameAr: 'الرياضة',
    icon: Icons.fitness_center_outlined,
    color: AppColors.sageMuted,
    searchQuery: 'sports fitness workout gym',
  ),
  Category(
    id: 'reading',
    name: 'Reading',
    nameAr: 'القراءة',
    icon: Icons.menu_book_outlined,
    color: AppColors.darkOlive,
    searchQuery: 'books reading library cozy',
  ),
  Category(
    id: 'photography',
    name: 'Photography',
    nameAr: 'التصوير',
    icon: Icons.camera_alt_outlined,
    color: AppColors.terracotta,
    searchQuery: 'photography camera aesthetic',
  ),
  Category(
    id: 'animals',
    name: 'Animals',
    nameAr: 'الحيوانات',
    icon: Icons.pets_outlined,
    color: AppColors.sageGreen,
    searchQuery: 'animals cute wildlife pet',
  ),
];
