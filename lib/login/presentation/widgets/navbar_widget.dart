import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hollat/core/global/theme/app_color/app_color_light.dart';
import 'package:hollat/core/init/gen/translations.g.dart';
import 'package:hollat/login/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (context, selectedPage, child) {
          return SizedBox(
            height: kBottomNavigationBarHeight + 40,
            // Adjust total height (56 + 30)
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // ClipPath(
                //   clipper: SoftCurvedTopClipper(),
                Container(
                  decoration: BoxDecoration(
                    color: AppColorsLight.whiteColor,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: LocaleKeys.home.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_balance),
                        label: LocaleKeys.sama.tr(),
                      ),
                      // Placeholder for center item (will be replaced)
                      BottomNavigationBarItem(
                        icon: SizedBox.shrink(),
                        label: '',
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset('assets/images/orders.svg'),
                        label: LocaleKeys.orders.tr(),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle_outlined),
                        label: LocaleKeys.myProfile.tr(),
                      ),
                    ],
                    currentIndex: selectedPageNotifier.value,
                    onTap: (value) {
                      if (value == 2) {
                        // Central button action can be handled here
                        // print("Central button tapped");
                      } else {
                        selectedPageNotifier.value = value;
                      }
                    },
                    selectedItemColor: AppColorsLight.colorPrimaryDark,
                    unselectedItemColor: AppColorsLight.gray,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.transparent,
                    elevation: 0, // Remove default shadow
                  ),
                ),
                //    )
                // Bottom Navigation Bar
                //  ,

                // Central Button
                Positioned(
                  bottom: kBottomNavigationBarHeight / 2,
                  // Center vertically relative to the bar, // Adjust to be above the navigation bar
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        width: 65,
                        height: 70,
                        decoration: BoxDecoration(
                          color: AppColorsLight.colorPrimaryDark,
                          // Background color of central button
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              offset: Offset(0.0, 5.0), // Shadow position
                            ),
                          ],
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: SvgPicture.asset(
                              'assets/images/add.svg',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ) // Replace with your icon
                        ),
                  ),
                ),
              ],
            ),
          );
        });

    //     return BottomNavigationBar(
    //       backgroundColor: AppColorsLight.whiteColor,
    //       items: [
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.home),
    //           label: LocaleKeys.home.tr(),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.account_balance),
    //           label: LocaleKeys.sama.tr(),
    //         ),
    //         // Central button separated from the normal items
    //         BottomNavigationBarItem(
    //           // Centralized icon (could be a Circle or FloatingActionButton)
    //           icon: Container(
    //             margin: EdgeInsets.only(bottom: 20),
    //             child: Stack(
    //               alignment: Alignment.center,
    //               children: [
    //                 CircleAvatar(
    //                   radius: 30,
    //                   backgroundColor: Colors.green,
    //                   child: Icon(Icons.add, color: Colors.white, size: 30),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           label: '', // No text label for the central item
    //         ),
    //         BottomNavigationBarItem(
    //           icon: SvgPicture.asset('assets/images/orders.svg'),
    //           label: LocaleKeys.orders.tr(),
    //         ),
    //         BottomNavigationBarItem(
    //           icon: Icon(Icons.account_circle_outlined),
    //           label: LocaleKeys.myProfile.tr(),
    //         ),
    //       ],
    //       currentIndex: selectedPage,
    //       onTap: (value) {
    //         if (value == 2) {
    //           // Handle the action for the central button separately
    //           // Example: Open a dialog or perform an action
    //           print("Central button tapped");
    //         } else {
    //           selectedPageNotifier.value = value;
    //         }
    //       },
    //       selectedItemColor: AppColorsLight.primaryColor,
    //       unselectedItemColor: Colors.grey,
    //       type: BottomNavigationBarType.fixed,
    //     );
    //   },
    // );
    //

    // return NavigationBar(
    //     surfaceTintColor: AppColorsLight.primaryColor,
    //     destinations: [
    //       NavigationDestination(
    //           icon: Icon(Icons.home), label: LocaleKeys.home.tr()),
    //       NavigationDestination(
    //           icon: Icon(Icons.account_balance),
    //           label: LocaleKeys.sama.tr()),
    //       NavigationDestination(
    //           icon: Icon(Icons.person), label: LocaleKeys.home.tr()),
    //       NavigationDestination(
    //           icon: SvgPicture.asset('assets/images/orders.svg'),
    //           label: LocaleKeys.orders.tr()),
    //       NavigationDestination(
    //           icon: Icon(Icons.account_circle_outlined),
    //           label: LocaleKeys.myProfile.tr())
    //     ],
    //     onDestinationSelected: (value) {
    //       selectedPageNotifier.value = value;
    //     },
    //     backgroundColor: AppColorsLight.whiteColor,
    //     selectedIndex: selectedPage,
    //     indicatorColor: AppColorsLight.primaryColor);
    // },
    // );
  }
}

// Custom ClipPath to create a gentle curve
class BottomNavClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50); // Start from bottom left
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50); // Curve
    path.lineTo(size.width, 0); // Complete the path
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 20); // Start at bottom-left with curve offset

    // Left curve
    path.quadraticBezierTo(
      size.width * 0.25, 0, // Control point
      size.width * 0.5, 0, // End point (center top)
    );

    // Right curve
    path.quadraticBezierTo(
      size.width * 0.75, 0, // Control point
      size.width, 20, // End point (bottom-right)
    );

    path.lineTo(size.width, size.height); // Close the path
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SoftCurvedTopClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = 25.0; // Adjust this to control curve depth

    // Start at bottom-left
    path.lineTo(0, size.height - curveHeight);

    // Left to center curve (gentle)
    path.quadraticBezierTo(
      size.width * 0.25, size.height, // Control point (lower position)
      size.width * 0.5, size.height - curveHeight, // End at center
    );

    // Center to right curve (gentle)
    path.quadraticBezierTo(
      size.width * 0.75, size.height - curveHeight * 2,
      // Control point (softer)
      size.width, size.height - curveHeight, // End at bottom-right
    );

    // Close the path
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
