import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_comics_app/features/comics/data/models/comics_model.dart';

abstract class ComicsRemoteDataSource {
  const ComicsRemoteDataSource();

  Future<List<ComicsModel>> getComics();
}

class ComicsRemoteDataSourceImpl implements ComicsRemoteDataSource {
  final String baseUrl = 'https://gateway.marvel.com:443/v1/public';
  final String publicKey = dotenv.env['MARVEL_PUBLIC_KEY']!;
  final String privateKey = dotenv.env['MARVEL_PRIVATE_KEY']!;
  final dio = Dio();

  String _generateHash(String timestamp) {
    return md5
        .convert(utf8.encode('$timestamp$privateKey$publicKey'))
        .toString();
  }

  @override
  Future<List<ComicsModel>> getComics() async {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String hash = _generateHash(timestamp);
    final String url =
        '$baseUrl/comics?orderBy=-modified&ts=$timestamp&apikey=$publicKey&hash=$hash';

    try {
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = response.data;
        final comicsList = (jsonResponse['data']['results'] as List)
            .map((comics) => ComicsModel.fromJson(comics))
            .toList();
        return comicsList;
      } else {
        throw Exception('Failed to load comics');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
