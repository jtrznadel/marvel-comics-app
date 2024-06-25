import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';
import 'package:marvel_comics_app/core/services/injection_container.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/home_screen.dart';
import 'package:marvel_comics_app/features/comics/presentation/views/search_screen.dart';

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
      appBar: AppBar(
        title: const Text(
          'Marvel Comics',
        ),
        scrolledUnderElevation: 10,
        shadowColor: Colors.black.withOpacity(.5),
        surfaceTintColor: AppColors.bgColor,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: AppColors.navIconColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: AppColors.navIconColor,
            ),
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
