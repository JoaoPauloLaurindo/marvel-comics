import './thumbnail_response_dto.dart';

class ComicResponseDto {
  final int id;
  final String title;
  final String? description;
  final int pageCount;
  final ThumbnailResponseDto thumbnail;

  ComicResponseDto({
    required this.id,
    required this.title,
    required this.description,
    required this.pageCount,
    required this.thumbnail,
  });

  factory ComicResponseDto.empty() {
    return ComicResponseDto(
      id: 0,
      title: '',
      description: '',
      pageCount: 0,
      thumbnail: ThumbnailResponseDto(
        path: '',
        extension: '',
      ),
    );
  }

  factory ComicResponseDto.fromMap(Map<String, dynamic> map) {
    return ComicResponseDto(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      pageCount: map['pageCount'],
      thumbnail: ThumbnailResponseDto.fromMap(map['thumbnail']),
    );
  }
}
