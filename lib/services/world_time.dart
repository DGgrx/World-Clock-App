import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location;
  String? dateTime;
  String? weekday;
  String? flag;
  String? uriLoc;
  String? date;
  bool isDaytime = true;
  DateTime now= DateTime.now();

  WorldTime({this.location, this.flag, this.uriLoc});

  Future<void> getTime() async {
    try {
      var url = Uri.parse("http://worldtimeapi.org/api/timezone/$uriLoc");
      Response response = await get(url);
      // print(response.body);
      Map data = jsonDecode(response.body);
      String utcDateTime = data["utc_datetime"];
      String utcOffsetHr = data["utc_offset"].substring(1, 3);
      String utcOffsetMin = data["utc_offset"].substring(4, 6);
      // print(utc_dateTime);
      // print(utc_offset_hr);
      // print(utc_offset_min);

      now = DateTime.parse(utcDateTime);
      now = now.add(Duration(
          hours: int.parse(utcOffsetHr), minutes: int.parse(utcOffsetMin)));


      dateTime = DateFormat.jms().format(now);
      weekday = DateFormat.EEEE().format(now);
      date = DateFormat.yMMMMd().format(now);
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;


    } catch (e) {
      dateTime = "Could not get time rn";
      weekday = "Could Not get Weekday Rn";
      date= "Could not get Date rn";
      isDaytime=false;

    }
  }
}
