import 'package:cloud_meeting/resources/auth_method.dart';
import 'package:cloud_meeting/resources/jitsi_meet_methods.dart';
import 'package:cloud_meeting/utils/colors.dart';
import 'package:cloud_meeting/widgets/meeting_options.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({Key? key}) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final AuthMethods _authMethods = AuthMethods();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();
  bool isAudioMuted = false;
  bool isVideoMuted = false;
  @override
  void initState() {
    meetingIdController = TextEditingController();
    nameController = TextEditingController(text: _authMethods.user.displayName);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();
    JitsiMeet.removeAllListeners();
  }

  _joinMeeting() {
    _jitsiMeetMethods.createMeeting(
      roomName: meetingIdController.text,
      isAudioMuted: isAudioMuted,
      isVideoMuted: isVideoMuted,
      username: nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text("join a Meeting",
            style: TextStyle(
              fontSize: 18,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: TextField(
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Room Id",
                  contentPadding: EdgeInsets.all(16)),
            ),
          ),
          SizedBox(
            height: 60,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  fillColor: secondaryBackgroundColor,
                  filled: true,
                  border: InputBorder.none,
                  hintText: "Name",
                  contentPadding: EdgeInsets.all(16)),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: _joinMeeting,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Join",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              )),
          const SizedBox(height: 30),
          MeetingOption(
              text: "Tap to Mute Audio",
              isMute: isAudioMuted,
              onChange: onAudioMuted),
          MeetingOption(
              text: "Tap to off Camera",
              isMute: isVideoMuted,
              onChange: onVideoMuted)
        ],
      ),
    );
  }

  onVideoMuted(bool val) {
    setState(() {
      isVideoMuted = val;
    });
  }

  onAudioMuted(bool val) {
    setState(() {
      isAudioMuted = val;
    });
  }
}
