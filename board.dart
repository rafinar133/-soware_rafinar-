import 'soware_image.dart';

class Board {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final List<SowareImage> images;
  final String coverImage;
  final bool isPrivate;

  Board({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdAt,
    this.images = const [],
    this.coverImage = '',
    this.isPrivate = false,
  });

  int get imageCount => images.length;

  Board copyWith({
    String? name,
    String? description,
    List<SowareImage>? images,
    String? coverImage,
    bool? isPrivate,
  }) {
    return Board(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt,
      images: images ?? this.images,
      coverImage: coverImage ?? this.coverImage,
      isPrivate: isPrivate ?? this.isPrivate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'images': images.map((img) => img.toJson()).toList(),
      'coverImage': coverImage,
      'isPrivate': isPrivate,
    };
  }

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      images: (json['images'] as List?)
          ?.map((img) => SowareImage.fromJson(img))
          .toList() ?? [],
      coverImage: json['coverImage'] ?? '',
      isPrivate: json['isPrivate'] ?? false,
    );
  }
}
