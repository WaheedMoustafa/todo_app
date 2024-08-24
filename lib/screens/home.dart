import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/extension/extension.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/screens/tabs/add_bottom_sheet.dart';
import 'package:todo_app/screens/tabs/list_tab.dart';
import 'package:todo_app/screens/tabs/settings_tab.dart';
import '../models/user_dm.dart';
import '../utils/app_colors.dart';

class Home extends StatefulWidget {
  static const String routeName = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  GlobalKey<ListTabState> listTabKey = GlobalKey();
  List<Widget> tabs = [];
  late ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    tabs = [
      ListTab(
        key: listTabKey,
      ),
      const SettingsTab()
    ];
  }

  @override
  Widget build(BuildContext context) {
    themeProvider=Provider.of(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkThemeEnabled ?AppColors.bgDark:AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        title: Text("${context.appLocalizations.welcome} ${UserDM.currentUser!.userName}"),
      ),
      body: tabs[currentIndex],
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavigation(),
    );
  }

  Widget buildBottomNavigation() => BottomAppBar(
    shape: const CircularNotchedRectangle(),
    notchMargin: 12,
    clipBehavior: Clip.hardEdge,
    child: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (tappedIndex) {
          currentIndex = tappedIndex;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Settings"),
        ]),
  );

  buildFab() => FloatingActionButton(
    onPressed: () async {
      await AddBottomSheet.show(context);
      listTabKey.currentState?.getTodosListFromFireStore();
    },
    backgroundColor: AppColors.primary,
    shape:  StadiumBorder(
        side: BorderSide(color: AppColors.white, width: 3)),
    child: const Icon(Icons.add),
  );
}