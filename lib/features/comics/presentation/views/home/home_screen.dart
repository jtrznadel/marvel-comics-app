import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics_app/core/common/widgets/loading_indicator.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/widgets/comics_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    context.read<ComicsCubit>().getComics();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context.read<ComicsCubit>().loadMoreComics();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: Text(
            'Marvel Comics',
            style: GoogleFonts.roboto(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Color(0xFF262424),
              ),
            ),
          ),
        ),
        scrolledUnderElevation: 10,
        shadowColor: Colors.black.withOpacity(.5),
        surfaceTintColor: AppColors.bgColor,
      ),
      body: BlocBuilder<ComicsCubit, ComicsState>(
        builder: (context, state) {
          if (state is ComicsLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is ComicsLoaded || state is ComicsLoadingMore) {
            final comics = state is ComicsLoaded
                ? state.comics
                : (state as ComicsLoadingMore).comics;
            return ListView.builder(
              controller: _scrollController,
              itemCount: comics.length + (state is ComicsLoadingMore ? 1 : 0),
              itemBuilder: (_, index) {
                if (index == comics.length) {
                  return const Center(child: LoadingIndicator());
                }
                final comic = comics[index];
                return ComicsTile(comics: comic);
              },
            );
          } else if (state is ComicsError) {
            return Center(
                child: Text('Failed to load comics: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
