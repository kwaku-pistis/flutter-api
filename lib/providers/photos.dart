import 'dart:convert';

import 'package:api_calls/models/photo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class PhotosService {
  final photoUrl = Uri.parse('https://jsonplaceholder.typicode.com/photos');

  Future<List<Photo>> getPhotos(http.Client client) async {
    var response = await client.get(photoUrl);

    //return parsePhotos(response.body);

    return compute(parsePhotos, response.body);

    // if (response.statusCode == 200) {
    //   final items = json.decode(response.body).cast<Map<String, dynamic>>();
    //   List<Photo> listOfPhotos = items.map<Photo>((json) {
    //     return Photo.fromJson(json);
    //   }).toList();
    //   return listOfPhotos;
    // } else {
    //   throw Exception('Failed to load photos');
    // }
  }

  List<Photo> parsePhotos(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }
}