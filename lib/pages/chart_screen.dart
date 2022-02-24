
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

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
      appBar: AppBar(),
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getDataChart(context);
              return const Center(child: CircularProgressIndicator());
            }
           // when we have the json loaded... let's put the data into a data table widget
           //  return SfCartesianChart(
           //
           //      primaryXAxis: CategoryAxis(
           //
           //      //  edgeLabelPlacement: EdgeLabelPlacement.shift,
           //      ),
           //      // Chart title
           //      title: ChartTitle(text: 'Half yearly sales analysis'),
           //      // Enable legend
           //      legend: Legend(isVisible: true),
           //      // Enable tooltip
           //      tooltipBehavior: TooltipBehavior(enable: true),
           //      series: <ChartSeries<ListOfMap, String>>[
           //
           //        LineSeries<ListOfMap, String>(
           //            dataSource: provider.listData!,
           //            xValueMapper: (ListOfMap sales, _) => sales.date,
           //            yValueMapper: (ListOfMap sales, _) => sales.numOfOrders,
           //            name: 'Sales',
           //            // Enable data label
           //            dataLabelSettings: DataLabelSettings(isVisible: true),
           //        ),
           //      ]);
          return SafeArea(
                    child: PageView(
                      physics: isDesktopOrWeb
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      children: _pages,
                    ),
                  ),
                  bottomNavigationBar: isDesktopOrWeb
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.transparent,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Visibility(
                                visible: _currentPage != 0,
                                child: FloatingActionButton(
                                  onPressed: () => _controller.previousPage(
                                      duration: _duration, curve: _curve),
                                  child: const Icon(Icons.chevron_left_rounded),
                                ),
                              ),
                              const Spacer(),
                              Visibility(
                                visible: _currentPage != _pages.length - 1,
                                child: FloatingActionButton(
                                  onPressed: () => _controller.nextPage(
                                      duration: _duration, curve: _curve),
                                  child: const Icon(Icons.chevron_right_rounded),
                                ),
                              ),
                            ],
                          ),
                        )



          },
        ),
      ),
    );
  }
}
