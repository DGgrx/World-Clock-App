import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  void setupTime() async{
    WorldTime instance = WorldTime(location: "India",flag: "india.png",uriLoc: "Asia/Kolkata");
    await instance.getTime();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'now': instance.now,
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.dateTime,
      'weekday': instance.weekday,
      'date':instance.date,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  void initState(){
    super.initState();
    setupTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[900],
      child: const Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
