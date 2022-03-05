import 'dart:convert';

import 'package:flapkap/pages/chart_screen.dart';
import 'package:flapkap/pages/count.dart';
import 'package:flapkap/pages/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../model/myData.dart';
class ListOfMap{
 late String date;
 late int numOfOrders;
 ListOfMap(this.date,this.numOfOrders);
}

class MyHomePageProvider extends ChangeNotifier {
  MyData? data;
  int count = 0;
  int returnCount = 0;
  double averagePrice = 0.0;
  String? averageToString;
  DateTime? tempDate;
  List<String> registeredListDate = [];
  List<String> registeredListSorted = [];
  var map = {};
  List<Map<String,dynamic>> listMap =[];
  List<ListOfMap>? listData ;


  Future getData(context) async {
    var response = await DefaultAssetBundle.of(context)
        .loadString('assets/raw/mJson.json');
    // now we have response as String from local json or and API request...
    var mJson = json.decode(response);
    // now we have a json...
    data = MyData.fromJson(mJson);
   
    for (int i = 0; i < data!.result!.length; i++) {
      // count number of returned orders
      if (data!.result![i].status == "RETURNED") {
        returnCount++;

      }
      // remove $ from the price
      String t = data!.result![i].price!.replaceAll("\$", '');
      // remove , from the price
      String f = t.replaceAll(",", '');
        // total price of all orders
      averagePrice += double.parse(f);
      // total orders
      count++;
    }
// average price for orders
    averagePrice = averagePrice / count;
    // convert price to string
    averageToString = averagePrice.toString();
// add $ and , to price
    averageToString = "\$" + averageToString!.substring(0, 1) + "," + averageToString!.substring(1);

    notifyListeners(); // for callback to view
  }

  Future getDataChart(context) async {
    var response = await DefaultAssetBundle.of(context)
        .loadString('assets/raw/mJson.json');
    // now we have response as String from local json or and API request...
    var mJson = json.decode(response);
    // now we have a json...
    data = MyData.fromJson(mJson);

    for (int i = 0; i < data!.result!.length; i++) {
       String d = data!.result![i].registered!.replaceAll(" -02:00", '');
       registeredListDate.add(d);
        tempDate  =  DateTime.parse(d);
   }
    
    registeredListDate.sort((a,b) {
      return DateTime.parse(a.toString()).compareTo(DateTime.parse(b.toString()));
    });
    
    for (int i = 0; i < data!.result!.length; i++) {
      tempDate  =  DateTime.parse(registeredListDate[i]);
      String formattedTime = DateFormat.MMM().format(tempDate!);
     registeredListSorted.add(formattedTime);
    }

    registeredListSorted.forEach((element) {
      if(!map.containsKey(element)) {
        map[element] = 1;

      } else {
        map[element] +=1;
      }
    });


 listData=   map.entries.map( (entry) => ListOfMap(entry.key, entry.value)).toList();

    notifyListeners(); // for callback to view
  }


  int currentIndex = 0;

  List<Widget> bottomScreens = [
    const HomeScreen(),
    const CountScreen(),
    const ChartScreen(),

  ];

  void changeBottom(int index) {
    currentIndex = index;
    notifyListeners(); // for callback to view
     }
}
