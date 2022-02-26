import 'package:flapkap/pages/count.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../provider/myHomePageProvider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyHomePageProvider>(
      builder: (context, provider, child) {
        if (provider.data == null) {
          provider.getData(context);
          return const Center(child: CircularProgressIndicator());
        }
        // when we have the json loaded... let's put the data into a data table widget
        return Scaffold(
          appBar: AppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text('FlapKap',style: TextStyle(color: Colors.black),),
          ),
          body: provider.bottomScreens[provider.currentIndex],
          //bottom nav bar
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            onTap: (index) {
              provider.changeBottom(index);
            },
            currentIndex: provider.currentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt_outlined),
                label: 'All Orders',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'Chart',
              ),

            ],
          ),
        );
      },
    );
  }
}
