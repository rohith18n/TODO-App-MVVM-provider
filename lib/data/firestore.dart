// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:towner_final_round/model/notes_model.dart';
import 'package:uuid/uuid.dart';

class FirestoreDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(String email) async {
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"id": _auth.currentUser!.uid, "email": email});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addNote(String subtitle, String title, int image) async {
    try {
      var uuid = const Uuid().v4();
      DateTime data = DateTime.now();
      // Add note to the 'notes' collection
      await _firestore.collection('notes').doc(uuid).set({
        'id': uuid,
        'subtitle': subtitle,
        'isDone': false,
        'image': image,
        'time': '${data.hour}:${data.minute}',
        'title': title,
      });
      // Add note reference to the user's collection
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .set({'id': uuid});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  List getNotes(snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note.fromJson(data);
      }).toList();
      return notesList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('notes')
        .where('isDone', isEqualTo: isDone)
        .snapshots();
  }

  Future<bool> isDone(String uuid, bool isDone) async {
    try {
      await _firestore.collection('notes').doc(uuid).update({'isDone': isDone});
      log("--- checkbox is working---");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateNote(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime data = DateTime.now();
      // Update note in the 'notes' collection
      await _firestore.collection('notes').doc(uuid).update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      // Update note in the user's collection
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteNote(String uuid) async {
    try {
      // Delete note from the 'notes' collection
      await _firestore.collection('notes').doc(uuid).delete();
      // Delete note from the user's collection
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('notes')
          .doc(uuid)
          .delete();
      log("---deleted successfully---");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateNotesForOtherUsers(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime data = DateTime.now();
      // Update note in the 'notes' collection
      await _firestore.collection('notes').doc(uuid).update({
        'time': '${data.hour}:${data.minute}',
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });

      // Get all users' documents
      final usersSnapshot = await _firestore.collection('users').get();
      for (var userDoc in usersSnapshot.docs) {
        final userId = userDoc.id;
        // Update note in each user's collection
        await _firestore
            .collection('users')
            .doc(userId)
            .collection('notes')
            .doc(uuid)
            .update({
          'time': '${data.hour}:${data.minute}',
          'subtitle': subtitle,
          'title': title,
          'image': image,
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
