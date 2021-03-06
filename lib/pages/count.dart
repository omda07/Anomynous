import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/myHomePageProvider.dart';

class CountScreen extends StatelessWidget {
  const CountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MyHomePageProvider>(
        builder: (context, provider, child) {
          if (provider.data == null) {
            provider.getData(context);
            return const Center(child: CircularProgressIndicator());
          }
          // when we have the json loaded... let's put the data into a data table widget
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: DataTable(
                decoration: BoxDecoration(color: Colors.white),
                columns: const [
                  DataColumn(
                      label: Text('Total Orders'),
                      tooltip: 'represents Total Orders'),
                  DataColumn(
                      label: Text('Average Price'),
                      tooltip: 'represents Average Price '),
                  DataColumn(
                      label: Text('Number of Returned'),
                      tooltip: 'represents Number of Returned orders'),
                ],
                rows: <DataRow>[
                  // we return a DataRow every time
                  DataRow(
                    // List<DataCell> cells is required in every row
                    cells: [
                      DataCell(Text(provider.count.toString())),
                      DataCell(Text(provider.averageToString.toString())),
                      DataCell(Text(provider.returnCount.toString())),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
