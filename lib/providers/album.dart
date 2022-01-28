import 'dart:convert';
import 'dart:io';

import 'package:api_calls/models/album.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');

  Future<http.Response> get() {
    return http.get(
      baseUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
      },
    );
  }

  Future<Album> getAlbum() async {
    final response = await http.get(baseUrl);
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Album> postAlbum(String title) async {
    final response = await http.post(
      baseUrl,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic your_api_token_here',
      },
      body: json.encode({
        'title': title,
        // 'title': 'New Album',
        'userId': 1,
      }),
    );
    if (response.statusCode == 201) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create album');
    }
  }
}