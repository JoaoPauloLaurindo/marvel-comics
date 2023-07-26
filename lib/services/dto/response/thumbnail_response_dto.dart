class ThumbnailResponseDto {
  final String path;
  final String extension;
  late String fullUrl;

  ThumbnailResponseDto({
    required this.path,
    required this.extension,
  }) {
    fullUrl = '$path.$extension';
  }

  factory ThumbnailResponseDto.fromMap(Map<String, dynamic> map) {
    return ThumbnailResponseDto(
      path: map['path'],
      extension: map['extension'],
    );
  }
}
