import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/models/app_user.dart';
import 'package:uuid/uuid.dart';

const String _dbUsers = 'users';
const String _dbAnimalAdoptions = 'animal_adoption';

class DatabaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AppUser getCurrentUser() => _currentUser;
  late final AppUser _currentUser;

  void setCurrentUser(AppUser currentUser) {
    _currentUser = currentUser;
  }

  Future<void> addUser(AppUser user) async {
    await _firebaseFirestore.collection(_dbUsers).doc(user.id).set(
          user.toJson(),
        );
  }

  Future<AppUser> getUser(String id) async {
    return _firebaseFirestore.collection(_dbUsers).doc(id).get().then(
          (data) => AppUser.fromJson(
            data.data()!,
          ),
        );
  }

  Future<void> addAdoption(AnimalAdoption adoption) async {
    await _firebaseFirestore
        .collection(_dbAnimalAdoptions)
        .doc(const Uuid().v4())
        .set(
          adoption.toJson(),
        );
  }

  Future<AnimalAdoption> getAdoption(String id) async {
    return _firebaseFirestore.collection(_dbAnimalAdoptions).doc(id).get().then(
          (data) => AnimalAdoption.fromJson(
            data.data()!,
          ),
        );
  }

  Future<List<AnimalAdoption>> getAdoptions(String id) async {
    return _firebaseFirestore.collection(_dbAnimalAdoptions).get().then(
          (data) => data.docs
              .map(
                (animalAdoption) => AnimalAdoption.fromJson(
                  animalAdoption.data(),
                ),
              )
              .toList(),
        );
  }

  Future<String> uploadImage(Uint8List imageBytes, String userId) async {
    final reference = _storage.ref('profile_picture/$userId.jpg');

    await reference.putData(
      imageBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return await reference.getDownloadURL();
  }
}
