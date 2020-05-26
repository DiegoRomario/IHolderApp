import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iholder_app/ui/android/screens/painel.screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'conta.screen.dart';
import 'lancamentos.screen.dart';

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
          LancamentosScreen(),
          PainelScreen(),
          ContaScreen(),
        ],
      ),
      bottomNavigationBar: new TabBar(
        controller: tabController,
        tabs: [
          Tab(
            icon: new Icon(MdiIcons.walletPlus),
          ),
          Tab(
            icon: new Icon(Icons.dashboard),
          ),
          Tab(
            icon: new Icon(MdiIcons.account),
          ),
        ],
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Theme.of(context).accentColor,
      ),
    );
  }
}
