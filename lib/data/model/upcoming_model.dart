class UpcomingModel {
  final String posterPath;
  final String releasceDate;

  UpcomingModel({required this.posterPath, required this.releasceDate});

  factory UpcomingModel.fromJson(Map<String, dynamic> json) {
    final String posterPath = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';

    final String releasceDate = '${json['releasce_date']} 예정';

    return UpcomingModel(posterPath: posterPath, releasceDate: releasceDate);
  }
}

// ○ 공개예정 액티비티
// - “공개예정 작품” 타이틀이 존재한다.
// - 최소 15개의 포스터와 공개 예정일이 함께 표시되어 가로 스크롤 되어 보여진다.
// - restAPI를 통해 구현 되었다. (공개예정)

// 포스터 이미지 주소
// https://image.tmdb.org/t/p/original/{{poster_path}}