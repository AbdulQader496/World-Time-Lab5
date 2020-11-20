import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time; //time int hat location
  String flag; // url to asset flag icon
  String url; // location url for api endpoints
  bool isDaytime; //true or false if it is day or night

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make request for time
      Response response =
          await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      //print(data);

      //get propertirs from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      //crweate Datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      isDaytime = now.hour > 6 && now.hour < 23 ? true : false;

      // set the time porperty in string
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('CAUGHT erroe: $e');
      time = 'Cannot get time';
    }
  }
}
