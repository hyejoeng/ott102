class TopRatedModel {
  final String posterPath;
  final String voteAverage;
  final List<int> genreIds;
  final int star;

  TopRatedModel({
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
    required this.star,
  });

  factory TopRatedModel.fromJson(Map<String, dynamic> json) {
    final String posterPath =
        'https://image.tmdb.org/t/p/original/${json['poster_path']}';

    final String voteAverage = json['vote_average'].toStringAsFixed(1);

    final int star = json['vote_average'] ~/ 2;

    final List<int> genreIds = [];
    for (var genreId in json['genre_ids']) {
      genreIds.add(genreId);
    }

    return TopRatedModel(
      posterPath: posterPath,
      voteAverage: voteAverage,
      genreIds: genreIds,
      star: star,
    );
  }
}

// 10점 만점 -> 5점 만점으로
// 새로운점수 = (기존 점수 / 10) * 5

// ○ 홈
// – 인기작품 1종 액티비티 (프로토타입 참고)
// - 영화 포스터, 점수+별점, 분류(애니메이션, 모험, 가족, 코메디)가 존재한다.
// - restAPI를 통해 구현 되었다. (인기 작품의 첫 번째)
// - 별점은 5점 만점 중 3점으로 표시되어 있다.

// 포스터 이미지 주소
// https://image.tmdb.org/t/p/original/{{poster_path}}
