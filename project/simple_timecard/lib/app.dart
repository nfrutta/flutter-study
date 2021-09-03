import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:simple_timecard/presentation/history/history_page.dart';
import 'package:simple_timecard/presentation/setting/setting_page.dart';
import 'package:simple_timecard/presentation/today/today_page.dart';

import 'app_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ja'),
      ],
      debugShowCheckedModeBanner: false, // debugアイコンを非表示に
      home: Scaffold(
        resizeToAvoidBottomInset: false, // キーボードによる画面リサイズを無効
        body: TopPage(),
      ),
    );
  }
}

class TopPage extends StatelessWidget {
  final List<String> _tabNames = [
    "今日",
    "履歴",
    "設定",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>(
      create: (_) => AppModel(),
      child: Consumer<AppModel>(
        builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  _tabNames[model.currentIndex],
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: Colors.white,
              ),
              body: _topPageBody(context),
              bottomNavigationBar: BottomNavigationBar(
                onTap: model.onTabTapped,
                currentIndex: model.currentIndex,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black38,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.today),
                    label: _tabNames[0],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.history),
                    label: _tabNames[1],
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: _tabNames[2],
                  ),
                ],
              ));
        },
      ),
    );
  }

  Widget _topPageBody(BuildContext context) {
    final model = Provider.of<AppModel>(context);
    final currentIndex = model.currentIndex;
    return Stack(
      children: <Widget>[
        _tabPage(currentIndex, 0, TodayPage()),
        _tabPage(currentIndex, 1, HistoryPage()),
        _tabPage(currentIndex, 2, SettingPage()),
      ],
    );
  }

  Widget _tabPage(int currentIndex, int tabIndex, StatelessWidget page) {
    return Visibility(
      visible: currentIndex == tabIndex,
      maintainState: true,
      child: page,
    );
  }
}
