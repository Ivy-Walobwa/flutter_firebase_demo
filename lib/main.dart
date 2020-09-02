import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase for Flutter Demo',
      home: Scaffold(
        body: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('places').snapshots(),
          builder: ( BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            final documents = snapshot.data.docs;
            return ListView.builder(
              itemBuilder: (ctx, idx) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(documents[idx].data()['city']),
                );
              },
              itemCount: documents.length,
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {

          },
        ),
      ),
    );
  }
}
