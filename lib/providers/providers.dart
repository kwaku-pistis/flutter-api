import 'dart:convert';

import 'package:api_calls/models/album.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final baseUrl = Uri.parse('https://jsonplaceholder.typicode.com/albums/1');

  Future<http.Response> get() {
    return http.get(baseUrl);
  }

  Future<Album> getAlbum() async {
    final response = await http.get(baseUrl);
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}