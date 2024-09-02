import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var playIndex = 0.obs;
  var isPlaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }
  playSong(String? uri, index){
    playIndex.value = index;
       try {
         audioPlayer.setAudioSource(
           AudioSource.uri(Uri.parse(uri!))
         );
         audioPlayer.play();
         isPlaying(true);
       }on Exception catch (e){
         print(e.toString());
       }
  }
  Future<void> checkPermission() async {
    // Request permission if not already granted
    if (await Permission.audio.request().isGranted) {
      print("Permission granted.");
      // Proceed with querying audio files
    } else {
      // If the permission is permanently denied, open app settings
      if (await Permission.audio.isPermanentlyDenied) {
        openAppSettings();
        print("Permission permanently denied. Please enable it from settings.");
      }
    }
  }
}