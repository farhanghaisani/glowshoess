import 'package:audioplayers/audioplayers.dart';
import 'package:glowshoess/model/speaker/audio_notification_model.dart';

class SettingsController {
  final AudioNotificationModel audioNotificationModel;

  SettingsController(this.audioNotificationModel);

  void toggleAudioNotification() {
    audioNotificationModel.toggleNotification();
  }

  void playNotificationSound() async {
    if (audioNotificationModel.isAudioNotificationEnabled) {
      final assetsAudioPlayer = AudioPlayer();
      try {
        await assetsAudioPlayer.play(AssetSource("asset/audio/ding.mp3"));
      } catch (e) {
        print("error : $e");
      }
    }
  }
}
