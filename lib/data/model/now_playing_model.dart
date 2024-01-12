class NowPlayingModel {
  final String posterPath;
  final String releaseDate;

  NowPlayingModel({required this.posterPath, required this.releaseDate});

  factory NowPlayingModel.fromJson(Map<String, dynamic> json) {
    final String posterPath = 'https://image.tmdb.org/t/p/original/${json['poster_path']}';

    return NowPlayingModel(
      posterPath: posterPath,
      releaseDate: json['release_date'],
    );
  }
}

// ○ 홈
// – 방영 중인 작품 액티비티
// - 영화 포스터가 6종 이상 존재하고 가로로 배치되어 있다. (프로토타입 참고)
// - 타이틀이 존재한다.
// - 좌우 스와이프 된다.
// - restAPI를 통해 구현 되었다. (방영 중인 작품)

// 포스터 이미지 주소
// https://image.tmdb.org/t/p/original/{{poster_path}}
