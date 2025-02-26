import 'package:flutter/material.dart';
import 'package:flutter_app/resources/pages/analisis_page.dart';
import 'package:flutter_app/resources/pages/dahsboard_page.dart';
// import 'package:flutter_app/resources/pages/home_page.dart';
import 'package:flutter_app/resources/pages/profil_page.dart';
import 'package:nylo_framework/nylo_framework.dart';

class BaseNavigationHub extends NyStatefulWidget with BottomNavPageControls {
  static RouteView path = ("/base", (_) => BaseNavigationHub());
  
  BaseNavigationHub()
      : super(
            child: () => _BaseNavigationHubState(),
            stateName: path.stateName());

  /// State actions
  static NavigationHubStateActions stateActions = NavigationHubStateActions(path.stateName());
}

class _BaseNavigationHubState extends NavigationHub<BaseNavigationHub> {

  /// Layouts: 
  /// - [NavigationHubLayout.bottomNav] Bottom navigation
  /// - [NavigationHubLayout.topNav] Top navigation
  NavigationHubLayout? layout = NavigationHubLayout.bottomNav(
    // backgroundColor: Colors.white,
  );

  /// Should the state be maintained
  @override
  bool get maintainState => true;

  /// Navigation pages
  _BaseNavigationHubState() : super(() async {
    return {
      0: NavigationTab(
        title: "Home",
        page: DahsboardPage(), // create using: 'dart run nylo_framework:main make:stateful_widget home_tab'
        icon: Icon(Icons.home),
        activeIcon: Icon(Icons.home),
      ),
      1: NavigationTab(
         title: "Analisis",
         page: AnalisisPage(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
         icon: Icon(Icons.analytics),
         activeIcon: Icon(Icons.analytics),
      ),
      2: NavigationTab(
         title: "Profile",
         page: ProfilPage(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
         icon: Icon(Icons.person),
         activeIcon: Icon(Icons.person),
      ),
      // 1: NavigationTab(
      //    title: "Settings",
      //    // page: SettingsTab(), // create using: 'dart run nylo_framework:main make:stateful_widget settings_tab'
      //    icon: Icon(Icons.settings),
      //    activeIcon: Icon(Icons.settings),
      // ),
    };
  });

  /// Handle the tap event
  @override
  onTap(int index) {
    super.onTap(index);
  }
}
