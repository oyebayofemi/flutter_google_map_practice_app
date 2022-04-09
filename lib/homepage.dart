import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_map_practice_app/allMarker.dart';
import 'package:google_map_practice_app/loading.dart';
import 'package:google_map_practice_app/map_sample.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

loadMap() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('markers')
        .orderBy('title', descending: false)
        .snapshots(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot dsnapshot = snapshot.data!.docs[index];
            print(dsnapshot.id);
            String uid = dsnapshot.id;
            //int k = 1;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MapSample(
                            uid,
                            dsnapshot['title'],
                            dsnapshot['lalng'].latitude,
                            dsnapshot['lalng'].longitude)));
              },
              child: Card(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(children: [
                  Text(
                    (index + 1).toString(),
                  ),
                  Text(dsnapshot['title']),
                  Text(dsnapshot['lalng'].latitude.toString()),
                  Text(dsnapshot['lalng'].longitude.toString()),
                  Text(dsnapshot['address']),
                ]),
              ),
            );
          },
        );
      } else {
        return Loading();
      }
    },
  );
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllMarker(),
                    ));
              },
              icon: Icon(Icons.article_rounded))
        ],
        title: Text('Locations'),
      ),
      body: loadMap(),
    );
  }
}
