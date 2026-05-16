import 'package:flutter/material.dart';
import '../models/board.dart';
import '../services/storage_service.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import 'board_detail_screen.dart';

class BoardsScreen extends StatefulWidget {
  @override
  _BoardsScreenState createState() => _BoardsScreenState();
}

class _BoardsScreenState extends State<BoardsScreen> {
  final StorageService _storageService = StorageService();
  List<Board> _boards = [];

  @override
  void initState() {
    super.initState();
    _loadBoards();
  }

  void _loadBoards() {
    setState(() => _boards = _storageService.getBoards());
  }

  void _createBoard() {
    showDialog(
      context: context,
      builder: (context) => _CreateBoardDialog(
        onCreate: (name, description) async {
          final board = Board(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            name: name,
            description: description,
            createdAt: DateTime.now(),
          );
          await _storageService.createBoard(board);
          _loadBoards();
          Navigator.pop(context);
        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'لوحاتي 📂',
                        style: AppTextStyles.headingLarge.copyWith(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: _createBoard,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 24),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${_boards.length} لوحة',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
          ),

          if (_boards.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.folder_open_outlined, size: 80,
                      color: AppColors.textMuted.withOpacity(0.5)),
                    SizedBox(height: 20),
                    Text('ما عندك حتى لوحة', style: AppTextStyles.headingMedium),
                    SizedBox(height: 8),
                    Text('أنشئ لوحة باش تنظم صورك', style: AppTextStyles.bodyMedium),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: _createBoard,
                      icon: Icon(Icons.add),
                      label: Text('لوحة جديدة'),
                    ),
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
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final board = _boards[index];
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => BoardDetailScreen(board: board)),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.cream,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 8, offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: board.coverImage.isEmpty
                                    ? AppColors.sageLight.withOpacity(0.3)
                                    : null,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                  image: board.coverImage.isNotEmpty
                                    ? DecorationImage(
                                        image: NetworkImage(board.coverImage),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                ),
                                child: board.coverImage.isEmpty
                                  ? Center(
                                      child: Icon(
                                        Icons.image_outlined,
                                        size: 40,
                                        color: AppColors.sageGreen,
                                      ),
                                    )
                                  : null,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    board.name,
                                    style: AppTextStyles.bodyLarge.copyWith(
                                      fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${board.imageCount} صورة',
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: _boards.length,
                ),
              ),
            ),

          SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}

class _CreateBoardDialog extends StatefulWidget {
  final Function(String name, String description) onCreate;
  const _CreateBoardDialog({required this.onCreate});

  @override
  __CreateBoardDialogState createState() => __CreateBoardDialogState();
}

class __CreateBoardDialogState extends State<_CreateBoardDialog> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.cream,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('لوحة جديدة',
        style: AppTextStyles.headingMedium, textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'سمية اللوحة',
              prefixIcon: Icon(Icons.folder_outlined),
            ),
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _descController,
            decoration: InputDecoration(
              hintText: 'وصف (اختياري)',
              prefixIcon: Icon(Icons.description_outlined),
            ),
            textDirection: TextDirection.rtl,
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('لغي'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              widget.onCreate(_nameController.text, _descController.text);
            }
          },
          child: Text('أنشئ'),
        ),
      ],
    );
  }
}
