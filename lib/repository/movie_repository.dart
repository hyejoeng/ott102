import 'dart:io';

import 'package:ott102/data/model/genre_model.dart';
import 'package:http/http.dart';

class MovieRepository {
  final _client = Client();

  static const String _baseUrl = 'api.themoviedb.org/3';

  static const String _apiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYTg1OTFjN2U0YzVjYWVjYjRlMDhhNzI3ODA2YWYxOSIsInN1YiI6IjY1OGQyYThmNTVjMWY0NjFkNDM5YTM3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t7K3U8egkt_gYmvaCGC9Hdc9OjDRzLtl0l4XA3i1_o4';

  Future<List<GenreModel>> getGenreList() async {
    // json 값을 담을 새로룬 리스트 추가, 타입은 GenreModel이다.
    final List<GenreModel> genreModel = [];

    final headers = {'Authorization' : 'Bearer $_apiKey'};

    // htpp Utl 생성
    // 예시
    // var uri = Uri.https('example.org', '/path', {'q': 'dart'});
    // print(uri); // <https://example.org/path?q=dart>
    final apiUrl = Uri.http(
      _baseUrl, '/genre/movie/list', {'language' : 'ko-KR', 'region' : 'KR'}
    );



    return genreModel;
    // Future<List<GenresModel>> getGenresList() async {
    //   final headers = {'Authorization': 'Bearer $apiKey'};
    //
    //   final apiUrl = Uri.https(
    //       baseUrl, '/3/genre/movie/list', {'language': 'ko-KR', 'region': 'KR',}
    //   );
    //
    //   final Response response = await client.get(apiUrl, headers: headers);
    //
    //   final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    //
    //   for (var genresJson in responseBody['genres']) {
    //     genresList.add(GenresModel.fromJson(genresJson as Map<String, dynamic>));
    //   }
    //
    //   return genresList;
    // }

    // var request = http.Request('GET', Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=ko-KR&region=KR'));
    //
    // request.headers.addAll(headers);
    //
    // http.StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // }
    // else {
    //   print(response.reasonPhrase);
    // }

  }
}

// Future<List<GenreModel>> getGenreList() async {
//   final headers = {'Authorization': 'Bearer $_apiKey'};
//   final apiUrl = Uri.https(
//     _baseUrl, '/3/genre/movie/list', {'language':'ko-KR', 'region':'KR'},
//   );
//
//   final response = await _apiCallHandling(apiUri: apiUrl, headers: headers);
//   if (response == null) {
//     return [];
//   }
//   final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
//
//   final List<GenreModel> genreList = [];
//   for (var genreJson in responseBody['genres']) {
//     genreList.add(GenreModel.fromJson(genreJson as Map<String, dynamic>));
//   }
//
//   return genreList;
// }

// var headers = {
//   'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlYTg1OTFjN2U0YzVjYWVjYjRlMDhhNzI3ODA2YWYxOSIsInN1YiI6IjY1OGQyYThmNTVjMWY0NjFkNDM5YTM3ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t7K3U8egkt_gYmvaCGC9Hdc9OjDRzLtl0l4XA3i1_o4'
// };
// var request = http.Request('GET', Uri.parse('https://api.themoviedb.org/3/genre/movie/list?language=ko-KR&region=KR'));
//
// request.headers.addAll(headers);
//
// http.StreamedResponse response = await request.send();
//
// if (response.statusCode == 200) {
// print(await response.stream.bytesToString());
// }
// else {
// print(response.reasonPhrase);
// }

// class StoreRepository {
//   Future<List<Store>> fetch(double lat, double lng) async {
//     final List<Store> stores = [];
//
//     var url = Uri.https('gist.githubusercontent.com',
//         '/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json');
//
//     try {
//       var response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
//
//         final jsonStores = jsonResult['stores'];
//
//         jsonStores.forEach((e) {
//           final store = Store.fromJson(e);
//           final meter =
//           Geolocator.distanceBetween(store.lat, store.lng, lat, lng);
//           store.km = meter / 1000;
//           stores.add(store);
//         });
//
//         return stores.where((e) {
//           return e.remainStat == 'plenty' ||
//               e.remainStat == 'some' ||
//               e.remainStat == 'few';
//         }).toList()
//           ..sort((a, b) => a.km.compareTo(b.km));
//       } else {
//         return [];
//       }
//     } catch (e) {
//       return [];
//     }
//   }
// }
