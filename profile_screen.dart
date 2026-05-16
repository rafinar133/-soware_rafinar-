import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StorageService _storageService = StorageService();
  int _savedCount = 0;
  int _likedCount = 0;
  int _boardsCount = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() {
    setState(() {
      _savedCount = _storageService.getSavedImages().length;
      _likedCount = _storageService.getLikedImages().length;
      _boardsCount = _storageService.getBoards().length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmBeige,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
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
                children: [
                  Container(
                    width: 100, height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 3,
                      ),
                    ),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text('ضيف',
                    style: AppTextStyles.headingLarge.copyWith(color: Colors.white)),
                  SizedBox(height: 4),
                  Text('مستخدم Guest',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.8))),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStat('المحفوظات', _savedCount, Icons.bookmark),
                      _buildDivider(),
                      _buildStat('الإعجابات', _likedCount, Icons.favorite),
                      _buildDivider(),
                      _buildStat('اللوحات', _boardsCount, Icons.folder),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الإعدادات', style: AppTextStyles.headingSmall),
                  SizedBox(height: 16),
                  _buildSettingTile(
                    icon: Icons.dark_mode_outlined,
                    title: 'الوضع الليلي',
                    subtitle: 'حماية العين فالليل',
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    icon: Icons.notifications_outlined,
                    title: 'الإشعارات',
                    subtitle: 'تفعيل الإشعارات',
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    icon: Icons.language,
                    title: 'اللغة',
                    subtitle: 'الدارجة المغربية',
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    icon: Icons.storage_outlined,
                    title: 'تخزين',
                    subtitle: 'إدارة الملفات المحفوظة',
                    onTap: () {},
                  ),

                  SizedBox(height: 20),
                  Divider(color: AppColors.divider),
                  SizedBox(height: 20),

                  Text('حول التطبيق', style: AppTextStyles.headingSmall),
                  SizedBox(height: 16),
                  _buildSettingTile(
                    icon: Icons.info_outline,
                    title: 'Soware Rafinar',
                    subtitle: 'الإصدار 1.0.0',
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'سياسة الخصوصية',
                    subtitle: 'كيفاش كنستعملو بياناتك',
                    onTap: () {},
                  ),
                  _buildSettingTile(
                    icon: Icons.help_outline,
                    title: 'المساعدة',
                    subtitle: 'أسئلة شائعة',
                    onTap: () {},
                  ),

                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: AppColors.cream,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                            title: Text('مسح كلشي?',
                              style: AppTextStyles.headingMedium,
                              textAlign: TextAlign.center),
                            content: Text(
                              'غادي تمسح كل الصور واللوحات المحفوظة. ماشي راجع!',
                              style: AppTextStyles.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('لغي'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await _storageService.clearAll();
                                  _loadStats();
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('تم المسح!'),
                                      backgroundColor: AppColors.sageGreen,
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.terracotta,
                                ),
                                child: Text('مسح'),
                              ),
                            ],
                          ),
                        );
                      },
                      icon: Icon(Icons.delete_outline),
                      label: Text('مسح كل البيانات'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.terracotta.withOpacity(0.1),
                        foregroundColor: AppColors.terracotta,
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(padding: EdgeInsets.only(bottom: 50)),
        ],
      ),
    );
  }

  Widget _buildStat(String label, int value, IconData icon) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(height: 8),
        Text(value.toString(),
          style: AppTextStyles.headingMedium.copyWith(color: Colors.white)),
        Text(label,
          style: AppTextStyles.caption.copyWith(
            color: Colors.white.withOpacity(0.8))),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40, width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.sageLight.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.sageGreen, size: 22),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600)),
                  SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}
