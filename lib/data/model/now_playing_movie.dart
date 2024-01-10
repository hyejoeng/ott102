class NowPlayingMovieModel {
  final String posterPath;
  final String releaseDate;
  
  NowPlayingMovieModel({required this.posterPath, required this.releaseDate});

  factory NowPlayingMovieModel.fromJson(Map<String, dynamic> json) {
    return NowPlayingMovieModel(posterPath: json['poster_path'], releaseDate: json['release_date']);
  }
}

// ○ 홈
// – 방영 중인 작품 액티비티
// - 영화 포스터가 6종 이상 존재하고 가로로 배치되어 있다. (프로토타입 참고)
// - 타이틀이 존재한다.
// - 좌우 스와이프 된다.
// - restAPI를 통해 구현 되었다. (방영 중인 작품)