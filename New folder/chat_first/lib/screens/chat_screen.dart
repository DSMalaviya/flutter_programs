import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartScreen extends StatelessWidget {
  CollectionReference datas = FirebaseFirestore.instance
      .collection('charts/sXVa2aHv2YzkMKypKgNI/messages/');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: datas.snapshots(includeMetadataChanges: true),
        builder: (ctx, streamsnapshot) {
          if (streamsnapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          final documents = streamsnapshot.data.docs;
          // print(documents.docs);
          print('done');
          return ListView.builder(
            itemBuilder: (context, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(documents[index]['text']),
            ),
            itemCount: documents.length,
          );
          // return Text('hello');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('charts/sXVa2aHv2YzkMKypKgNI/messages')
              .add({'text': 'This was added by clicking this button!'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
