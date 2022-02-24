import 'package:flapkap/pages/count.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/myHomePageProvider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Count()),
              );
            },
            child: Text(
              'Count Screen',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getData(context);
              return const Center(child: CircularProgressIndicator());
            }
            // when we have the json loaded... let's put the data into a data table widget
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(
                        label: Text('Active'), tooltip: 'represents if Active'),
                    DataColumn(
                        label: Text('id'), tooltip: 'represents order id'),
                    DataColumn(
                        label: Text('Buyer'),
                        tooltip: 'represents Buyer name of the order'),
                    DataColumn(
                        label: Text('Company'),
                        tooltip: 'represents Company name of the order'),
                    DataColumn(
                        label: Text('Price'),
                        tooltip: 'represents Price of the order'),
                    DataColumn(
                        label: Text('Tags'),
                        tooltip: 'represents Tags of the order'),
                    DataColumn(
                        label: Text('Registered'),
                        tooltip:
                            'represents date and  time Registered of the order'),
                    DataColumn(
                        label: Text('Status'),
                        tooltip: 'represents Status of the order'),
                  ],
                  rows: provider.data!.result!
                      .map((data) =>
                          // we return a DataRow every time
                          DataRow(
                              // List<DataCell> cells is required in every row
                              cells: [
                                DataCell(
                                  (data.isActive!)
                                      ? const Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : const Icon(Icons.cancel,
                                          color: Colors.red),
                                ),
                                // I want to display a green color icon when user is verified and red when unverified
                                DataCell(Text(data.id!)),
                                DataCell(Text(data.buyer!)),
                                DataCell(Text(data.company!)),
                                DataCell(Text(data.price!)),
                                DataCell(Text(data.tags.toString())),
                                DataCell(Text(data.registered!)),
                                DataCell(Text(data.status!)),
                                // DataCell(Text(data.price!)),
                              ]))
                      .toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
