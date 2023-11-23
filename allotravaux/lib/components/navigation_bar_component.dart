import 'package:allotravaux/assets/my_flutter_app_icons.dart';
import 'package:allotravaux/views/all_conversations_view.dart';
import 'package:flutter/material.dart';

import '../resources/background_decoration.dart';
import '../resources/style.dart';
import '../views/favorite_view.dart';
import '../views/project_view.dart';

class NavigationBarComponent extends StatefulWidget {
  const NavigationBarComponent({super.key});

  @override
  State<NavigationBarComponent> createState() => _NavigationBarComponentState();
}

int selectedIndex = 0;

Route createRoute(myPage) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
      pageBuilder: (context, animation, secondaryAnimation) => myPage);
}

class _NavigationBarComponentState extends State<NavigationBarComponent> {
  @override
  Widget build(BuildContext context) {
    void onItemTapped(int index) {
      int lastSelected = selectedIndex;
      selectedIndex = index;
      if (index == 0 && lastSelected != index) {
        Navigator.pop(context);
        Navigator.of(context).push(createRoute(ProjectsView()));
        //context.read<NavigationBloc>().add(ProjectsViewEvent());
      } else if (index == 1 && lastSelected != index) {
        Navigator.of(context).push(createRoute(const FavoriteView()));
        //context.read<NavigationBloc>().add(FavViewEvent());
      } else if (index == 2 && lastSelected != index) {
        Navigator.of(context).push(createRoute(const AllConversationsView()));
        //context.read<NavigationBloc>().add(ConvViewEvent());
      }
    }

    return Container(
        decoration: navBackgroundDecoration,
        child: BottomNavigationBar(
          iconSize: 30,
          unselectedItemColor: lowWhite,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.maison),
              label: 'Projets',
            ),
            BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.etoile), label: 'Favoris'),
            BottomNavigationBarItem(
                icon: Icon(MyFlutterApp.bulles), label: 'Conversations'),
          ],
          currentIndex: selectedIndex,
          onTap: onItemTapped,
        ));
  }
}
