class TopRatedMovieModel {
  final String posterPath;
  final double voteAverage;

  TopRatedMovieModel({required this.posterPath, required this.voteAverage});

  factory TopRatedMovieModel.fromJson(Map<String, dynamic> json) {
    return TopRatedMovieModel(posterPath: json['poster_path'], voteAverage: json['vote_average']);
  }
}

// ○ 홈
// – 인기작품 1종 액티비티 (프로토타입 참고)
// - 영화 포스터, 점수+별점, 분류(애니메이션, 모험, 가족, 코메디)가 존재한다.
// - restAPI를 통해 구현 되었다. (인기 작품의 첫 번째)
// - 별점은 5점 만점 중 3점으로 표시되어 있다.

// 포스터 이미지 주소
// https://image.tmdb.org/t/p/original/{{poster_path}}