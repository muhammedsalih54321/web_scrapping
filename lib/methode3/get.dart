// controller.dart
import 'package:get/get.dart';

class DataController extends GetxController {
  List<String> name = [];
  List<String> location = [];

  void addName(String value) {
    name.add(value);
    update(); // This is important to notify the UI
  }

  void addLocation(String value) {
    location.add(value);
    update(); // This is also important
  }
}
