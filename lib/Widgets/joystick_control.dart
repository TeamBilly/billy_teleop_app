import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:control_pad/views/joystick_view.dart';
import 'package:flutter/material.dart';
import 'package:ros_nodes/ros_nodes.dart';
import 'package:ros_nodes/messages/geometry_msgs/Twist.dart';
import 'package:vector_math/vector_math.dart';

import '../constants.dart';

class JoystickController extends StatefulWidget {
  final String robotIP;
  final String deviceIP;
  final void Function(Offset) onChange;
  const JoystickController({
    this.robotIP,
    this.deviceIP,
    this.onChange,
    Key key,}) : super(key: key);

  @override
  _JoystickControllerState createState() => _JoystickControllerState();
}

class _JoystickControllerState extends State<JoystickController> {
  //static var ip = RobotAndDeviceIP(robotIP:widget.robotIP, deviceIP:this.widget.deviceIP);
  GeometryMsgsTwist msg = GeometryMsgsTwist();
  double speed = 2;
  bool _buttonPressed = false;
  bool _loopActive = false;

  @override
  void initState() {
    super.initState();
  }

  static robotIP() => robotIP_global;
  static deviceIP() => deviceIP_global;
/*
  static var config = RosConfig(
    'ros_arrow_key_controller',
    'http://'+ robotIP() +':11311/',
    //'100.88.20.135',
    deviceIP(),
    24125,
  );
  */
  static var config = RosConfig(
    'ros_joystick_controller',
    'http://'+ robotIP() +':11311/',
    //'100.88.20.135',
    deviceIP(),
    24125,
  );
  var client = RosClient(config);
  var topic = RosTopic('cmd_vel', GeometryMsgsTwist());

  void onClickMove(move) async {
    await client.unregister(topic);

    var publisher = await client.register(topic,
        publishInterval: Duration(milliseconds: 100));
      // do your thing

      setState(() {
        topic.msg.linear.x = move.x;
        topic.msg.angular.z = move.rotz;
        print("topic.msg.linear.x = ${topic.msg.linear.x}");
      });
  }

  Offset delta = Offset.zero;

  void updateDelta(Offset newDelta) {
    widget.onChange(newDelta);
    setState(() {
      delta = newDelta;
      //print("x: ${delta.dx} y:${delta.dy}");
      double linearX = -delta.dy;
      double rotationZ = -delta.dx;
      print("x: $linearX y:$rotationZ");
      onClickMove(Move(linearX, rotationZ));
    });
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(60, 60);
    updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(30, newDelta.distance),
      ),
    );
  }
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x88ffffff),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Transform.translate(
                offset: delta,
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xccffffff),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
          ),
          onPanDown: onDragDown,
          //TODO Fix the onPanUpdate function to add a continuous control
          //onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,
        ),
      ),
    );
  }
  void onDragDown(DragDownDetails d) {
    calculateDelta(d.localPosition);
  }

  void onDragUpdate(DragUpdateDetails d) async {
    //await Future.delayed(Duration(milliseconds: 100));
    calculateDelta(d.localPosition);
  }

  void onDragEnd(DragEndDetails d) {
    updateDelta(Offset.zero);

  }

}
Padding padding() {
  return new Padding(padding: EdgeInsets.only(left: 71));

}

class Move {
  double x;
  double rotz;
  Move(this.x, this.rotz);
}

