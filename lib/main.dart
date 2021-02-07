import 'package:flutter/material.dart';
import 'package:roslib/roslib.dart';
import 'Pages/navigation_page.dart';
import 'Routes/transition_route_observer.dart';
import 'Widgets/arrow_control.dart';
import 'Pages/arrow_teleop.dart';
import 'Widgets/camera.dart';
import 'Pages/login_page.dart';
import 'Pages/map_real_time.dart';

/*
Launch the terminal commands
$roslaunch turtlebot3_gazebo turtlebot3_world.launch
$roslaunch rosbridge_server rosbridge_websocket.launch
$rosrun web_video_server web_video_server
*/
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Turtlebot Controller',
      home: LoginPage(),
      navigatorObservers: [TransitionRouteObserver()],
      routes: {
        LoginPage.routeName: (context) => LoginPage(),
        ArrowTeleop.routeName: (context) => ArrowTeleop(),
        NavigationPage.routeName: (context) => NavigationPage(),
        MapRealTime.routeName: (context) => MapRealTime(),

      },
    );

  }
}
