import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/notifiers.dart';
import 'package:hollat/login/presentation/widgets/navbar_widget.dart';
import 'package:hollat/login/views/home_page.dart';
import 'package:hollat/login/views/login/normal_login_page.dart';
import 'package:hollat/login/views/profile_page.dart';
import 'package:hollat/main/riverpod/providers.dart';

import 'settings/settings_page.dart';

//mport 'package:shared_preferences/shared_preferences.dart';

List<Widget> pages = [const HomePage(), const ProfilePage()];
String title = 'Holat';

class NavPage extends ConsumerWidget {
  const NavPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
      final isDarkMode = ref.watch(localStorageViewModelProvider);
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(title),
          //  centerTitle: true,
          // leading: Icon(Icons.login),
          actions: [
            //   Text('Login'),
            IconButton(
                onPressed: ()  {
                  ref.read(localStorageViewModelProvider.notifier).changeDarkMode(!isDarkMode);
                }
                // async{
                //   modeNotifier.value = !modeNotifier.value;
                //   final SharedPreferences prefs = await SharedPreferences.getInstance();
                //   await prefs.setBool(Constants.modeKey, modeNotifier.value   );
                //
                // }
                , icon: isDarkMode ? const Icon(Icons.light_mode) :const Icon(Icons.dark_mode) ),
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
          backgroundColor: Colors.teal,
        ),
        bottomNavigationBar: const NavbarWidget(),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              onPressed: () {
                print('ffff');
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
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
