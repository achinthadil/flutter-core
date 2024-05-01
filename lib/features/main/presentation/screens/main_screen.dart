import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/route_paths.dart';
import '../blocs/main_bloc.dart';

class MainScreen extends StatelessWidget {
  final Widget child;

  const MainScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final mainBloc = context.watch<MainBloc>();
    int currentIndex = mainBloc.state is TabState
        ? (mainBloc.state as TabState).currentIndex
        : 0;

    return Scaffold(
      body: child, // Directly use the child provided by the ShellRoute
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          if (!context.read<MainBloc>().isClosed) {
            context.read<MainBloc>().add(TabUpdated(index));
            context.go(_getPathForIndex(index));
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  String _getPathForIndex(int index) {
    switch (index) {
      case 0:
        return CoreRoutePaths.home;
      case 1:
        return CoreRoutePaths.users;
      case 2:
        return CoreRoutePaths.notifications;
      case 3:
        return CoreRoutePaths.settings;
      default:
        return CoreRoutePaths.home;
    }
  }
}
