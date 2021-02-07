import 'package:flutter/material.dart';
import 'package:roslib/roslib.dart';


import 'login_page.dart';
import '../Routes/transition_route_observer.dart';
import '../Widgets/camera.dart';
import '../constants.dart';
class MapRealTime extends StatefulWidget {
  MapRealTime({Key key}) : super(key: key);
  static const routeName = '/map_real_time';
  _MapRealTimeState createState() => _MapRealTimeState();
}

class _MapRealTimeState extends State<MapRealTime> with TransitionRouteAware{
  Ros ros;
  Topic chatter;
  //String robotIPX = "137.195.116.79";
  static robotIP() => robotIP_global;
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
        title: Text('Map Observation'),
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
                    height: 250,
                    width: 350,
                    child: MyWebView(
                      title: "TurtleBotView",
                      selectedUrl:
                      streamUrl
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    height: 250,
                    width: 350,
                    child: MyWebView(
                      title: "TurtleBotMap",
                      selectedUrl:
                      'http:/'+ robotIP() +':8080/stream?topic=/image_from_occupancy&type=mjpeg&quality=80&width=350&height=350',

                    ),
                  ),
                ],
              ),
            ),
          ]

      ),
    );
  }
}