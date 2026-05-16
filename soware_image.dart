class SowareImage {
  final String id;
  final String url;
  final String thumbUrl;
  final String title;
  final String category;
  final String photographer;
  final int width;
  final int height;
  final bool isLiked;
  final bool isSaved;
  final DateTime? savedAt;

  SowareImage({
    required this.id,
    required this.url,
    required this.thumbUrl,
    required this.title,
    required this.category,
    required this.photographer,
    required this.width,
    required this.height,
    this.isLiked = false,
    this.isSaved = false,
    this.savedAt,
  });

  factory SowareImage.fromUnsplash(Map<String, dynamic> json) {
    return SowareImage(
      id: json['id'] ?? '',
      url: json['urls']['regular'] ?? '',
      thumbUrl: json['urls']['small'] ?? '',
      title: json['alt_description'] ?? json['description'] ?? 'صورة جميلة',
      category: 'عام',
      photographer: json['user']['name'] ?? 'مصور مجهول',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
    );
  }

  SowareImage copyWith({
    bool? isLiked,
    bool? isSaved,
    DateTime? savedAt,
  }) {
    return SowareImage(
      id: id,
      url: url,
      thumbUrl: thumbUrl,
      title: title,
      category: category,
      photographer: photographer,
      width: width,
      height: height,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      savedAt: savedAt ?? this.savedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
      'thumbUrl': thumbUrl,
      'title': title,
      'category': category,
      'photographer': photographer,
      'width': width,
      'height': height,
      'isLiked': isLiked,
      'isSaved': isSaved,
      'savedAt': savedAt?.toIso8601String(),
    };
  }

  factory SowareImage.fromJson(Map<String, dynamic> json) {
    return SowareImage(
      id: json['id'],
      url: json['url'],
      thumbUrl: json['thumbUrl'],
      title: json['title'],
      category: json['category'],
      photographer: json['photographer'],
      width: json['width'],
      height: json['height'],
      isLiked: json['isLiked'] ?? false,
      isSaved: json['isSaved'] ?? false,
      savedAt: json['savedAt'] != null ? DateTime.parse(json['savedAt']) : null,
    );
  }
}
