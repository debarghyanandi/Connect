import 'dart:math';
import 'package:cloud_meeting/resources/jitsi_meet_methods.dart';
import 'package:flutter/material.dart';

import '../widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);
  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.pushNamed(context, '/video-call');
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HomeMeetingButton(
            onpressed: createNewMeeting,
            text: "New Meeting",
            icon: Icons.videocam,
          ),
          HomeMeetingButton(
            onpressed: () => joinMeeting(context),
            text: "Join Meeting",
            icon: Icons.add_box_rounded,
          ),
          HomeMeetingButton(
            onpressed: () {},
            text: "Schedule",
            icon: Icons.calendar_month,
          ),
          HomeMeetingButton(
            onpressed: () {},
            text: "Share Screen",
            icon: Icons.arrow_upward_outlined,
          )
        ],
      ),
      const Expanded(
          child: Center(
              child: Text(
        "Host/Join Meetings With Just One Click",
        style: TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      )))
    ]);
  }
}
