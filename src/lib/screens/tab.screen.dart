import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iholder_app/screens/registrations.screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'account.screen.dart';
import 'dashboard.screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          RegistrationScreen(),
          DashboardScreen(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: new TabBar(
        controller: tabController,
        tabs: [
          Tab(
            icon: new Icon(MdiIcons.cashPlus),
          ),
          Tab(
            icon: new Icon(Icons.dashboard),
          ),
          Tab(
            icon: new Icon(Icons.perm_identity),
          ),
        ],
        labelColor: Theme.of(context).primaryColor,
        unselectedLabelColor: Colors.black38,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
