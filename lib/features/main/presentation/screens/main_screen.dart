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
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          if (!context.read<MainBloc>().isClosed) {
            context.read<MainBloc>().add(TabUpdated(index));
            context.go(_getPathForIndex(index));
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Tab 1',
          ),
          NavigationDestination(
            icon: Icon(Icons.people),
            label: 'Tab 2',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications),
            label: 'Tab 3',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Tab 4',
          ),
        ],
      ),
    );
  }

  String _getPathForIndex(int index) {
    switch (index) {
      case 0:
        return CoreRoutePaths.main;
      case 1:
        return CoreRoutePaths.feature2;
      case 2:
        return CoreRoutePaths.feature3;
      case 3:
        return CoreRoutePaths.feature4;
      default:
        return CoreRoutePaths.main;
    }
  }
}
