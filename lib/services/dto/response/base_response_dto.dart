class BaseResponseDto<T> {
  final List<T> results;

  BaseResponseDto({required this.results});

  factory BaseResponseDto.fromMap(Map<String, dynamic> map) {
    return BaseResponseDto(results: map['results']);
  }
}
