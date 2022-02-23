import 'dart:convert';

import 'package:flutter/widgets.dart';

import '../model/myData.dart';

class MyHomePageProvider extends ChangeNotifier {
  MyData? data;

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
    int count=0;
    double avg =0.0;
    for(int i = 0;i<data!.result!.length;i++){
      if(data!.result![i].status=="RETURNED")
      {
        String t=data!.result![i].price!.replaceAll("\$", '');
        String f=t.replaceAll(",", '');
       // print(f);
       avg += double.parse(f);
          count++;
      }

    }
    String average=avg.toString();

    String x="\$"+average.substring(0,1)+","+average.substring(1);
    print(x);
    print(count);
    notifyListeners(); // for callback to view
  }

}