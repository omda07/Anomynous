import 'package:flapklap/provider/myHomePageProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Json Parsing Demo'),
      ),
      body: ChangeNotifierProvider<MyHomePageProvider>(
        create: (context) => MyHomePageProvider(),
        child: Consumer<MyHomePageProvider>(
          builder: (context, provider, child) {
            if (provider.data == null) {
              provider.getData(context);
              return const Center(child:  CircularProgressIndicator());
            }
            // when we have the json loaded... let's put the data into a data table widget
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              // Data table widget in not scrollable so we have to wrap it in a scroll view when we have a large data set..
              child: SingleChildScrollView(
                child: DataTable(
                  columns:const [
                     DataColumn(
                        label:  Text('Active'),
                        tooltip: 'represents if user is verified.'),
                     DataColumn(
                        label:  Text('id'),
                        tooltip: 'represents first name of the user'),
                     DataColumn(
                        label:  Text('Buyer'),
                        tooltip: 'represents last name of the user'),
                     DataColumn(
                        label:Text ('Company'),
                        tooltip: 'represents email address of the user'),
                    DataColumn(
                        label:Text ('Price'),
                        tooltip: 'represents email address of the user'),
                     DataColumn(
                        label:  Text('Tags'),
                        tooltip: 'represents phone number of the user'),
                    DataColumn(
                        label:  Text('Registered'),
                        tooltip: 'represents phone number of the user'),
                    DataColumn(
                        label:  Text('Status'),
                        tooltip: 'represents phone number of the user'),
                  ],
                  rows: provider.data!.result!
                      .map((data) =>
                          // we return a DataRow every time
                          DataRow(
                              // List<DataCell> cells is required in every row
                              cells: [
                                DataCell((data.isActive!)
                                    ? const Icon(
                                        Icons.verified_user,
                                        color: Colors.green,
                                      )
                                    : const Icon(Icons.cancel, color: Colors.red)),
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
