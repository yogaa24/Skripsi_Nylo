import 'package:nylo_framework/nylo_framework.dart';
import '/app/services/firebase_service.dart';

class ExampleController extends NyController {
  Future<void> fetchData() async {
    try {
      dynamic data = await FirebaseService.instance.getData('users/123');
      print(data.toString());
    } catch (e) {
      print('Error: ${e.toString()}');
    }
  }
}