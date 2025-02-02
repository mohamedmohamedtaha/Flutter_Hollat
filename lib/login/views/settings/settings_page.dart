import 'package:flutter/material.dart';
import 'package:hollat/login/Navigator.dart';
import 'package:hollat/login/data/styles.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.title});

  final String title;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? menuItem = 'e1';
  bool? isChecked = false;
  bool isSwitch = false;
  double sliderValue = 0.0;
void simpleDialog()async{
  switch(await AlertDialog(
  title: const Text('Alert Dialog'),
  content: const Text('Alert Message'),
  actions: [
    SimpleDialogOption(child: Text('YEs'),onPressed: ()=> Navigator.pop(context,'YES'),)
    ,SimpleDialogOption(child: Text('YEs'),onPressed: ()=> Navigator.pop(context,'NO'),)
    ,SimpleDialogOption(child: Text('YEs'),onPressed: ()=> Navigator.pop(context,'May be'),)
  ,FilledButton(
  onPressed: () {
  navigatorControllerPup(context);
  },
  child: const Text('Close'))
  ],
  )){
    case 'YES': //do something
      break;
    case 'NO': //do something
      break;case 'May be': //do something
    break;

  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          automaticallyImplyLeading: false, // f you want to hide back button
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // GestureDetector For make anything clickable or InkWell
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Image.asset('assets/images/background.jpg'),
                ),
                InkWell(
                  splashColor: Colors.teal,
                  onTap: () {},
                  child: const SizedBox(
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 40.0)),
                  onPressed: () {},
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Login"),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white),
                  onPressed: () {},
                  child: const Text("Login"),
                ),
                TextButton(

                  onPressed: () {},
                  child: const Text("Login"),
                ),
                OutlinedButton(
                  // style: ElevatedButton.styleFrom(foregroundColor: Colors.white),
                  onPressed: () {},
                  child: const Text("Login"),
                ),
                const CloseButton(),
                BackButton(
                  onPressed: () {},
                  // child: Text("Login"),
                ),
                DropdownButton(
                    value: menuItem,
                    items: const [
                      DropdownMenuItem(value: 'e1', child: Text('Element1')),
                      DropdownMenuItem(value: 'e2', child: Text('Element2')),
                      DropdownMenuItem(value: 'e3', child: Text('Element3'))
                    ],
                    onChanged: (value) {
                      setState(() {
                        menuItem = value;
                      });
                    }),
                const Divider(
                  color: Colors.teal,
                  thickness: 1.0,
                  // indent: 100.0,
                  //endIndent: 200.0,
                ),
                const SizedBox(
                  height: 50.0,
                  child: VerticalDivider(
                    color: Colors.teal,
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Alert Dialog'),
                            content: const Text('Alert Message'),
                            actions: [
                              FilledButton(
                                  onPressed: () {
                                    navigatorControllerPup(context);
                                  },
                                  child: const Text('Close'))
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Alert Dialog')),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Alert Dialog'),
                            content: const Text('Alert Message'),
                            actions: [
                              SimpleDialogOption(child: Text('YEs'),onPressed: ()=> navigatorControllerPup(context),)
                              ,FilledButton(
                                  onPressed: () {
                                    navigatorControllerPup(context);
                                  },
                                  child: const Text('Close'))
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Simple Dialog')),
                ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          content: Text('SnackBar')));
                    },
                    child: const Text('Snack Bar')),
                const SizedBox(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How Are You',
                            style: CStyles.titleTealText,
                          ),
                          Text('Fine Thanks')
                        ],
                      ),
                    ),
                  ),
                ),
                CheckboxListTile.adaptive(
                  //    tristate: true,
                  value: isChecked,
                  title: const Text('List'),
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                SwitchListTile.adaptive(
                  title: const Text('Swithc Me'),
                  value: isSwitch,
                  onChanged: (value) {
                    setState(() {
                      isSwitch = value;
                    });
                  },
                ),
                Slider.adaptive(
                  max: 20.0,
                  divisions: 20,
                  value: sliderValue,
                  onChanged: (value) {
                    setState(() {
                      sliderValue = value;
                    });
                  },
                ),
                Column(
                  children: List.generate(
                    5,
                        (index) {
                      return Slider.adaptive(
                        max: 20.0,
                        divisions: 20,
                        value: sliderValue,
                        onChanged: (value) {
                          setState(() {
                            sliderValue = value;
                          });
                        },
                      );
                    },
                  ),
                ),
                ...List.generate(
                  5,
                      (index) {
                    return Slider.adaptive(
                      max: 20.0,
                      divisions: 20,
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          sliderValue = value;
                        });
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
