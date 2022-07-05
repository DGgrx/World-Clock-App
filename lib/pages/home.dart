import 'package:flutter/material.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)!.settings.arguments as Map;
    String bgImg = data["isDaytime"] ? "day.png" : "night.png";
    Color txtThim =
        data["isDaytime"] ? Colors.deepPurple.shade900 : Colors.grey.shade400;

    String getUpdatedTime() {
      data['now'] = data['now'].add(const Duration(seconds: 1));
      String later = DateFormat.jms().format(data['now']);
      return later;
    }

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/$bgImg"), fit: BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 160.0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');
                  setState(() {
                    data = {
                      'now': result["now"],
                      'location': result["location"],
                      'flag': result["flag"],
                      'time': result["time"],
                      'weekday': result["weekday"],
                      'date': result["date"],
                      'isDaytime': result["isDaytime"],
                    };
                  });
                },
                icon: Icon(
                  Icons.edit_location,
                  color: txtThim,
                  size: 30.0,
                ),
                label: Text(
                  "ChooseLocation",
                  style: TextStyle(color: txtThim, fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/${data["flag"]}"),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Text(
                    data["location"],
                    style: TextStyle(color: txtThim, fontSize: 25.0),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              TimerBuilder.periodic(const Duration(seconds: 1),
                  builder: (context) {
                return Text(
                  getUpdatedTime(),
                  style: TextStyle(
                      color: txtThim,
                      fontSize: 50,
                      fontWeight: FontWeight.w700),
                );
              }),
              const SizedBox(
                height: 10.0,
              ),
              Text(
                // "Date",
                data["date"],
                style: TextStyle(color: txtThim, fontSize: 20.0),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                data["weekday"],
                style: TextStyle(color: txtThim, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
