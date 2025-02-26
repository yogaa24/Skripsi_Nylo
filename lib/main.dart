import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:nylo_framework/nylo_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'bootstrap/boot.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase terlebih dahulu dengan pengecekan platform
  if (!kIsWeb) {
    // Untuk platform mobile/desktop
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print('Firebase initialization error (native): $e');
    }
  }

  // Inisialisasi Nylo
  await Nylo.init(
    setup: Boot.nylo,
    setupFinished: (Nylo nylo) async {
      // Inisialisasi Firebase untuk web platform
      if (kIsWeb) {
        try {
          await Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          );
        } catch (e) {
          print('Firebase initialization error (web): $e');
        }
      }
      await Boot.finished(nylo); 
    },
    showSplashScreen: true,
  );
}