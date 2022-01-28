import 'package:api_calls/models/photo.dart';
import 'package:api_calls/providers/photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  _PhotosPageState createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  late Future<List<Photo>> _future;
  final _photoService = PhotosService();

  @override
  void initState() {
    super.initState();
    _future = _photoService.getPhotos(http.Client());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Photos'),
        ),
        body: Container(
          margin: const EdgeInsets.all(0),
          // padding: const EdgeInsets.all(10),
          child: FutureBuilder<List<Photo>>(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final photo = snapshot.data![index];
                    // return Container(
                    //   margin: const EdgeInsets.all(10),
                    //   child: Column(
                    //     children: [
                    //       Image.network(
                    //         photo.url,
                    //         fit: BoxFit.cover,
                    //       ),
                    //       Text(photo.title, textAlign: TextAlign.left,),
                    //     ],
                    //   ),
                    // );
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: Image.network(photo.thumbnailUrl),
                        title: Text(photo.title),
                      )
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
