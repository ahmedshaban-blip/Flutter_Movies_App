import 'package:dio/dio.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  late final Dio dio;

  ApiClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        // 'Authorization': 'Bearer YOUR_TOKEN',
      },
    ));

    // إضافة إنتركبتور لالتقاط الطلبات والاستجابات
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // هنا يمكن إضافة لوج للطلبات
        print('➡️ [${options.method}] ${options.uri}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        // هنا يمكن إضافة لوج للاستجابات
        print('✅ [${response.statusCode}] ${response.data}');
        return handler.next(response);
      },
      onError: (err, handler) {
        // هنا يمكن التعامل مع الأخطاء
        print('❌ ${err.message}');
        return handler.next(err);
      },
    ));
  }

  Future<List<Movie>> fetchMovies() async {
    try {
      Response response = await dio
          .get("/3/movie/now_playing?api_key=29cf44b93ca83bf48d9356395476f7ad");
      if (response.statusCode == 200) {
        List movies = response.data['results'];
        return movies
            .map(
              (e) => Movie.fromJson(e),
            )
            .toList();
      } else {
        throw Exception("Failed to load movies");
      }
    } on DioException {
      rethrow;
    }
  }
}
