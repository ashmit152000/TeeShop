import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Favourites with ChangeNotifier {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> addFavourites(
      {String merch_name = '',
      int merch_id = 0,
      String merch_url = '',
      String user_id = '',
      int merch_cost = 0}) async {
    CollectionReference fav = instance.collection('favourites');

    try {
      fav
          .add({
            'merch_name': merch_name,
            'merch_id': merch_id,
            'merch_url': merch_url,
            'user_id': user!.uid,
            'merch_cost': merch_cost,
          })
          .then((value) => print('Added'))
          .catchError((error) => print(error));
    } catch (error) {
      print(error);
    }
  }

  void removeFavourites() {}
}
