import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_comics_app/core/res/media_res.dart';
import 'package:marvel_comics_app/core/services/injection_container.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/home_screen.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/search/search_screen.dart';

class NavigationShell extends StatefulWidget {
  const NavigationShell({super.key});

  static const routeName = '/navigation-shell';

  @override
  State<NavigationShell> createState() => _NavigationShellState();
}

class _NavigationShellState extends State<NavigationShell> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
      create: (context) => sl<ComicsCubit>(),
      child: const HomeScreen(),
    ),
    BlocProvider(
      create: (context) => sl<ComicsCubit>(),
      child: const SearchScreen(),
    ),
  ];

  void _onScreenSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(MediaRes.inactiveHomeIcon),
            activeIcon: Image.asset(MediaRes.activeHomeIcon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(MediaRes.inactiveSearchIcon),
            activeIcon: Image.asset(MediaRes.activeSearchIcon),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onScreenSelected,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
