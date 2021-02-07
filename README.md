# billyteleopapp

The objective of the application is to interact with the robot Billy by doing teleoperation and
visualize its data.

## Launch the application
### Flutter
This application is designed to work this the robot Billy. Before building the application,
it's required to enter the Robot and smartphone IP in the file constants.dart.
The login page is not working in this commit so you can directly access to the different pages
by clicking on the button related.
In function of the manipulations done with the robot, the streamUrl will also need to be modified
to get the required image topic data.

### ROS
The application requires to run the nodes web_video_server and rosbridge_websocket to perform
the communication with ROS.

## Implemented features
### Teleoperation
The first feature implemented is the teleoperation, the robot can be controlled by using a
directional cross which will publish on the cmd_vel topic.

### Navigation Control
The second feature is map visualizer which allows to send goal to the navigation package of the
robot by clicking on the robot map.