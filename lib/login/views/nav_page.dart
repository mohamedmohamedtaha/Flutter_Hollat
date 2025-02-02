import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/notifiers.dart';
import 'package:hollat/login/presentation/widgets/navbar_widget.dart';
import 'package:hollat/main/presentation/views/complaint_page.dart';
import 'package:hollat/main/presentation/views/home_page.dart';
import 'package:hollat/main/presentation/views/orders_page.dart';
import 'package:hollat/main/presentation/views/profile_page.dart';
import 'package:hollat/main/presentation/views/sama_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

import 'settings/settings_page.dart';

List<Widget> pages = [
  const HomePage(),
  const SamaPage(),
  const ComplaintPage(),
  const ProfilePage(),
  const OrdersPage()
];
String title = 'Holat';

class NavPage extends ConsumerWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(localStorageViewModelProvider);
    return Scaffold(
      backgroundColor: AppColorsLight.moreLightGray,
      appBar: AppBar(
        backgroundColor:AppColorsLight.colorPrimaryDark,
        automaticallyImplyLeading: true,
        title: Text(title),
        //  centerTitle: true,
        leading: Icon(Icons.notification_add,),
        actions: [
          Icon(Icons.person, color: AppColorsLight.whiteColor,),
          Text('Hello'),
          IconButton(
              onPressed: () {
                ref
                    .read(localStorageViewModelProvider.notifier)
                    .changeDarkMode(!isDarkMode);
              }
              // async{
              //   modeNotifier.value = !modeNotifier.value;
              //   final SharedPreferences prefs = await SharedPreferences.getInstance();
              //   await prefs.setBool(Constants.modeKey, modeNotifier.value   );
              //
              // }
              ,
              icon: isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode)),
          //   Text('Your name'),
          //   Icon(Icons.phone),
          IconButton(
              onPressed: () {
                // Open new page
                navigatorControllerPush(
                    context, const SettingsPage(title: 'Settings'));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      bottomNavigationBar: const NavbarWidget(),
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, value, child) {
          return pages.elementAt(value);
        },
      ),
      // Drawer or SafeArea
      // drawer: Drawer(
      //   child: Column(
      //     children: [
      //       // DrawerHeader(
      //       //   child: Text('Hollat'),
      //       // ),
      //       ListTile(
      //         title: Text('Logout'),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}