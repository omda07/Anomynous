import 'dart:convert';

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
  String? average;
  DateTime? tempDate;
  List<String> z = [];
  var map = {};
  List<Map<String,dynamic>> listMap =[];
  List<ListOfMap>? listData ;
  Future getData(context) async {
    // You can call an API to get data, once we've the data from API or any other flow... Following part would always be the same.
    // We forgot about one more important part .. lets do that first

    // We need access to BuildContext for loading this string and it's not recommended to store this context in any variable here
    // in change notifier..
    var response = await DefaultAssetBundle.of(context)
        .loadString('assets/raw/mJson.json');
    // now we have response as String from local json or and API request...
    var mJson = json.decode(response);
    // now we have a json...
    data = MyData.fromJson(mJson);
    //print(data!.result![0].price);

    for (int i = 0; i < data!.result!.length; i++) {
      if (data!.result![i].status == "RETURNED") {
        returnCount++;
        // print(returnCount);

      }
      String t = data!.result![i].price!.replaceAll("\$", '');
      String f = t.replaceAll(",", '');

      averagePrice += double.parse(f);
      count++;
    }

    averagePrice = averagePrice / count;
    average = averagePrice.toString();

    average = "\$" + average!.substring(0, 1) + "," + average!.substring(1);
    print("Orders count : ${count}");
    print('avergae price : ${average}');
    print('Returened count : ${returnCount}');

    notifyListeners(); // for callback to view
  }

  Future getDataChart(context) async {
    // You can call an API to get data, once we've the data from API or any other flow... Following part would always be the same.
    // We forgot about one more important part .. lets do that first

    // We need access to BuildContext for loading this string and it's not recommended to store this context in any variable here
    // in change notifier..
    var response = await DefaultAssetBundle.of(context)
        .loadString('assets/raw/mJson.json');
    // now we have response as String from local json or and API request...
    var mJson = json.decode(response);
    // now we have a json...
    data = MyData.fromJson(mJson);
    //print(data!.result![0].price);



    for (int i = 0; i < data!.result!.length; i++) {

      z.add(data!.result![i].registered!);


      //   String d = data!.result![i].registered!.replaceAll(" -02:00", '');
      //   d = d.replaceAll("-", '');
      //   d = d.replaceAll(":", '');
      //  // String f=d.replaceAll(",", '');
      // //  print(d);
      //   tempDate  =  DateTime.parse(d);
      //   String formattedTime = DateFormat.Hms().format(tempDate);
      //   if(formattedTime == formattedTime){
      //
      //
      //   }
      // print(formattedTime);
      //
      // z.add(formattedTime);

    }
    z.forEach((element) {
      if(!map.containsKey(element)) {
        map[element] = 1;

      } else {
        map[element] +=1;
      }
    });


 listData=   map.entries.map( (entry) => ListOfMap(entry.key, entry.value)).toList();
print("hhhhhhhhhhhhhhhhhhh${listData![0].date}");
print(listData!.length.toDouble());
    //print(map);
    notifyListeners(); // for callback to view
  }
}
