import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  Future<void> checkPermission() async {
    // Check if permission is granted
    var permissionStatus = await Permission.audio.status;

    // If permission is denied, request it
    if (!permissionStatus.isGranted) {
      var result = await Permission.audio.request();

      // If permission is still denied, handle it (e.g., show a dialog)
      if (result.isDenied) {
        // Handle permission denial, maybe show a dialog or explanation
        print("Permission denied.");
      } else if (result.isPermanentlyDenied) {
        // Handle permanent denial, guide user to settings
        print("Permission permanently denied. Please enable it from settings.");
      } else if (result.isGranted) {
        // Permission is granted, proceed
        print("Permission granted.");
      }
    } else {
      // Permission is already granted, proceed
      print("Permission already granted.");
    }
  }
}