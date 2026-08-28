import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveService {
  static const String appId = String.fromEnvironment('AGORA_APP_ID', defaultValue: '');
  static RtcEngine? _engine;
  static bool isJoined = false;

  static Future<RtcEngine> initBroadcaster() async {
    await [Permission.camera, Permission.microphone].request();
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await _engine!.enableVideo();
    await _engine!.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine!.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(dimensions: VideoDimensions(width: 720, height: 1280)),
    );
    return _engine!;
  }

  static Future<RtcEngine> initAudience() async {
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    await _engine!.enableVideo();
    await _engine!.setClientRole(role: ClientRoleType.clientRoleAudience);
    return _engine!;
  }

  static Future<void> joinChannel(String channelName) async {
    await _engine!.joinChannel(token: '', channelId: channelName, uid: 0, options: const ChannelMediaOptions());
    isJoined = true;
  }

  static Future<void> leave() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    isJoined = false;
  }

  static RtcEngine? get engine => _engine;
}
