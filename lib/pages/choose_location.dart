import 'package:flutter/material.dart';
import 'package:world_clock/services/world_time.dart';

class LocationChoose extends StatefulWidget {
  const LocationChoose({Key? key}) : super(key: key);

  @override
  State<LocationChoose> createState() => _LocationChooseState();
}

class _LocationChooseState extends State<LocationChoose> {
  List<WorldTime> locations = [
    WorldTime(uriLoc: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(uriLoc: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(uriLoc: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(uriLoc: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(uriLoc: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(uriLoc: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(uriLoc: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(uriLoc: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(uriLoc: 'Asia/Kolkata', location: 'India', flag: 'india.png'),
  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    if (!mounted) return;
    Navigator.pop(context, {
      'now':instance.now,
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.dateTime,
      'weekday': instance.weekday,
      'date':instance.date,
      'isDaytime': instance.isDaytime,
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Choose a Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 1.0,
              horizontal: 4.0
            ),
            child: Card(
              child: ListTile(
                onTap: () {
                  updateTime(index);
                },
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20.0
                ),
                title: Text(
                  "${locations[index].location}",
                  style: const TextStyle(
                    fontSize: 20.0
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/${locations[index].flag}"),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
