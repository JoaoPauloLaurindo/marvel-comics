import './thumbnail_response_dto.dart';

class ComicResponseDto {
  final int id;
  final String title;
  final String? description;
  final ThumbnailResponseDto thumbnail;

  ComicResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
  });

  factory ComicResponseDto.fromMap(Map<String, dynamic> map) {
    return ComicResponseDto(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      thumbnail: ThumbnailResponseDto.fromMap(map['thumbnail']),
    );
  }
}
