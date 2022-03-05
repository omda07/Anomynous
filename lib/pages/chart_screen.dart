import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../provider/myHomePageProvider.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  ListOfMap? listOfMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getDataChart(context);
              return const Center(child: CircularProgressIndicator());
            }
            return SfCartesianChart(
              primaryXAxis: CategoryAxis(),

              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<ListOfMap, String>>[
                LineSeries<ListOfMap, String>(
                  dataSource: provider.listData!,
                  xValueMapper: (ListOfMap orders, _) => orders.date,
                  yValueMapper: (ListOfMap orders, _) => orders.numOfOrders,
                  name: 'Orders',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
