// app/services/firebase_service.dart
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static FirebaseService? _instance;
  late FirebaseDatabase database;

  static FirebaseService get instance {
    _instance ??= FirebaseService();
    return _instance!;
  }

  Future<void> init() async {
    database = FirebaseDatabase.instance;
  }

  // Metode untuk membaca data
  Future<dynamic> getData(String path) async {
    DatabaseReference ref = database.ref(path);
    final snapshot = await ref.get();
    return snapshot.value;
  }

  // Metode untuk menulis data
  Future<void> setData(String path, dynamic data) async {
    DatabaseReference ref = database.ref(path);
    await ref.set(data);
  }

  // Metode untuk memperbarui data
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    DatabaseReference ref = database.ref(path);
    await ref.update(data);
  }

  // Metode untuk menghapus data
  Future<void> deleteData(String path) async {
    DatabaseReference ref = database.ref(path);
    await ref.remove();
  }

  // Metode untuk mendengarkan perubahan realtime
  Stream<DatabaseEvent> streamData(String path) {
    DatabaseReference ref = database.ref(path);
    return ref.onValue;
  }
}