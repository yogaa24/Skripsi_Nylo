import 'package:nylo_framework/nylo_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/firebase_service.dart';

class FirebaseProvider implements NyProvider {
  Future<Nylo?> boot(Nylo nylo) async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "YOUR_API_KEY",
        appId: "YOUR_APP_ID",
        messagingSenderId: "YOUR_SENDER_ID",
        projectId: "YOUR_PROJECT_ID",
        databaseURL: "YOUR_DATABASE_URL"
      ),
    );
    
    await FirebaseService.instance.init();
    return nylo;
  }

  Future<void> afterBoot(Nylo nylo) async {
    // Kode yang akan dijalankan setelah boot
  }
}
