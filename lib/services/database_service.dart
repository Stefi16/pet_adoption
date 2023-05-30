import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:pet_adoption/models/animal_adoption.dart';
import 'package:pet_adoption/models/app_user.dart';
import 'package:pet_adoption/models/chat_model.dart';

const String _dbUsers = 'users';
const String _dbAnimalAdoptions = 'animal_adoption';
const String _dbChats = 'chats';

class DatabaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  AppUser getCurrentUser() => _currentUser;
  AppUser _currentUser = AppUser.createNew('', '');

  List<AppUser> getAllUsers() => _users;

  AppUser getUserById(String id) {
    return _users.where((user) => user.id == id).first;
  }

  List<AppUser> _users = [];

  final List<AnimalAdoption> _animalAdoptions = [];

  List<AnimalAdoption> get animalAdoptions => _animalAdoptions;

  final List<ChatModel> _chats = [];

  List<ChatModel> get chats => _chats;

  void initDatabaseService({
    required AppUser currentUser,
    required List<AnimalAdoption> animalAdoptions,
    required List<AppUser> users,
    required List<ChatModel> chats,
  }) {
    _currentUser = currentUser;
    _animalAdoptions.addAll(animalAdoptions);
    _users = users;
    _chats.addAll(chats);
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

  Future<List<AppUser>> getUsers() async {
    return _firebaseFirestore.collection(_dbUsers).get().then(
          (data) => data.docs
              .map(
                (animalAdoption) => AppUser.fromJson(
                  animalAdoption.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<AppUser>> getUsersStream() {
    return _firebaseFirestore
        .collection(_dbUsers)
        .snapshots()
        .map((query) => query.docs)
        .map(
          (docs) => docs
              .map(
                (e) => AppUser.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> addAdoption(AnimalAdoption adoption) async {
    await _firebaseFirestore
        .collection(_dbAnimalAdoptions)
        .doc(adoption.adoptionId)
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

  Future<List<AnimalAdoption>> getAdoptions() async {
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

  Future<bool> deleteAdoption(String id) async {
    try {
      await _firebaseFirestore.collection(_dbAnimalAdoptions).doc(id).delete();
      await _deleteAdoptionImage(id);

      final chatsToDelete = chats.where((chat) => chat.adoptionId == id);
      for (final chat in chatsToDelete) {
        chats.removeWhere(
          (c) => chat.chatId == c.chatId,
        );
        await deleteChat(chat.chatId);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<List<AnimalAdoption>> getAdoptionsStream() {
    return _firebaseFirestore
        .collection(_dbAnimalAdoptions)
        .snapshots()
        .map((query) => query.docs)
        .map(
          (docs) => docs
              .map(
                (e) => AnimalAdoption.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Future<void> addChat(ChatModel model) async {
    await _firebaseFirestore.collection(_dbChats).doc(model.chatId).set(
          model.toJson(),
        );

    final existingChat = _chats.where((chat) => chat.chatId == model.chatId);
    if (existingChat.isNotEmpty) {
      existingChat.first.messages = model.messages;
    } else {
      _chats.add(model);
    }
  }

  Future<List<ChatModel>> getChats() async {
    return _firebaseFirestore.collection(_dbChats).get().then(
          (data) => data.docs
              .map(
                (animalAdoption) => ChatModel.fromJson(
                  animalAdoption.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<ChatModel>> getChatsStream() {
    return _firebaseFirestore
        .collection(_dbChats)
        .snapshots()
        .map((query) => query.docs)
        .map(
          (docs) => docs
              .map(
                (e) => ChatModel.fromJson(
                  e.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<ChatModel> getChatStream(String chatId) {
    return _firebaseFirestore.collection(_dbChats).doc(chatId).snapshots().map(
          (event) => ChatModel.fromJson(
            event.data()!,
          ),
        );
  }

  Future<void> deleteChat(String id) async {
    await _firebaseFirestore.collection(_dbChats).doc(id).delete();
  }

  Future<String> uploadImage(Uint8List imageBytes, String userId) async {
    final reference = _storage.ref('profile_picture/$userId.jpg');

    await reference.putData(
      imageBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return await reference.getDownloadURL();
  }

  Future<String> uploadChatImage(Uint8List imageBytes, String id) async {
    final reference = _storage.ref('chat_image$id.jpg');

    await reference.putData(
      imageBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return await reference.getDownloadURL();
  }

  Future<String> uploadAdoptionImage(
      Uint8List imageBytes, String adoptionId) async {
    final reference = _storage.ref('adoption_picture/$adoptionId.jpg');

    await reference.putData(
      imageBytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );

    return await reference.getDownloadURL();
  }

  Future<void> _deleteAdoptionImage(String adoptionId) async {
    final reference = _storage.ref('adoption_picture/$adoptionId.jpg');

    await reference.delete();
  }
}
