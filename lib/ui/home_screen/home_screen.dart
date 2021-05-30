import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app5/provider/page_view_provider.dart';
import 'package:flutter_app5/ui/home_screen/pages/members_screen.dart';
import 'package:flutter_app5/ui/home_screen/pages/purchases_screen.dart';
import 'package:flutter_app5/ui/home_screen/pages/statistics_screen.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart';

import 'comopnents/app_floating_action_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> titles = [
    'الأعضاء',
    'المشتريات',
    'الإحصائيات',
  ];

  final List<Widget> screens = [
    MembersScreen(),
    PurchasesScreen(),
    StatisticsScreen(),
  ];

  final pageController = PageController(initialPage: 0);
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    setLocaleMessages('ar', ArMessages());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: ChangeNotifierProvider(
        lazy: false,
        create: (_) => PageViewProvider(
            pageController: pageController, scaffoldKey: _scaffoldKey),
        builder: (context, _) => Scaffold(
          floatingActionButton: AppFloatingActionButton(),
          appBar: AppBar(
            centerTitle: true,
            title: Consumer<PageViewProvider>(
              builder: (_, provider, __) {
                return AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    child: Text(
                      titles[provider.pageIndex],
                      key: Key(provider.pageIndex.toString()),
                    ));
              },
            ),
          ),
          bottomNavigationBar: Consumer<PageViewProvider>(
            builder: (_, provider, __) => BottomNavigationBar(
              iconSize: 28,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                Provider.of<PageViewProvider>(context, listen: false)
                    .toPage(index);
              },
              currentIndex: provider.pageIndex,
              items: [
                _getBottomItem(iconData: Icons.group_outlined),
                _getBottomItem(iconData: Icons.home_outlined),
                _getBottomItem(iconData: Icons.stacked_bar_chart),
              ],
            ),
          ),
          body: PageView(
            children: screens,
            controller: pageController,
            onPageChanged: (index) {
              Provider.of<PageViewProvider>(context, listen: false).pageIndex =
                  index;
            },
          ),
        ),
      ),
    );
  }

  _getBottomItem({required IconData iconData}) {
    return BottomNavigationBarItem(
        icon: Icon(
          iconData,
        ),
        activeIcon: Icon(
          iconData,
          size: 30,
        ),
        label: '');
  }
}
