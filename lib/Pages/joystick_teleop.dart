import 'package:billyteleopapp/Routes/transition_route_observer.dart';
import 'package:billyteleopapp/Widgets/joystick_control.dart';
import 'package:flutter/material.dart';
import 'package:roslib/roslib.dart';
import '../Widgets/arrow_control.dart';
import '../Widgets/camera.dart';
import '../constants.dart';
import 'login_page.dart';

class JoystickTeleop extends StatefulWidget {
  JoystickTeleop({Key key}) : super(key: key);
  static const routeName = '/joystick_teleop';
  _JoystickTeleopState createState() => _JoystickTeleopState();
}

class _JoystickTeleopState extends State<JoystickTeleop> with TransitionRouteAware{
  Ros ros;
  Topic chatter;
  //String robotIPX = "137.195.116.79";
  static robotIP() => robotIP_global;
  static deviceIP() => deviceIP_global;
  @override
  void initState() {
    ros = Ros(url: 'ws://'+ robotIP() +':9090');
    chatter = Topic(
        ros: ros, name: '/chatter', type: "std_msgs/String", reconnectOnClose: true, queueLength: 10, queueSize: 10);
    super.initState();
  }

  void initConnection() async {
    ros.connect();
    await chatter.subscribe();
    setState(() {});
  }

  void destroyConnection() async {
    await chatter.unsubscribe();
    await ros.close();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    RobotAndDeviceIP ip = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Robot Teleoperation'),
      ),
      body: Stack(
          children:
          [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  )
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 350,
                    width: 350,
                    child: VideoWebView(
                        title: "TurtleBotView",
                        selectedUrl:
                        streamUrl
                    ),
                  ),
                  SizedBox(height: 30.0),
                  JoystickController(
                    robotIP: robotIP(),
                    deviceIP: ip.deviceIP,
                    onChange: (Offset delta) => print(delta),
                  ),
                ],
              ),
            ),
          ]

      ),
    );
  }
}