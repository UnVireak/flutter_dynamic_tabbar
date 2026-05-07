import 'package:dio/dio.dart';

import '../model/post_model.dart';

class HomeRepository {

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );

  Future<List<PostModel>> fetchPosts({
    required int userId,
  }) async {

    final response = await dio.get(
      '/posts',
      queryParameters: {
        'userId': userId,
      },
    );

    final data = (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    return data.take(userId).toList();
  }
}