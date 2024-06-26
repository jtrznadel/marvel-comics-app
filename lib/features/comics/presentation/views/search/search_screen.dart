import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics_app/core/common/widgets/loading_indicator.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';
import 'package:marvel_comics_app/core/res/media_res.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/widgets/comics_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool _showCancelButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _showCancelButton = _searchController.text.isNotEmpty;
    });
    String query =
        _searchController.text.isNotEmpty ? _searchController.text : '_empty_';
    context.read<ComicsCubit>().getSpecificComics(query);
  }

  void _onCancelSearch() {
    _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _showCancelButton = false;
    });
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      context
          .read<ComicsCubit>()
          .loadMoreSpecificComics(_searchController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for a comic book',
                    prefixIcon: Icon(
                      Icons.search,
                      color: _showCancelButton
                          ? AppColors.activeIconColor
                          : AppColors.inctiveIconColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    filled: true,
                    fillColor: AppColors.inputFieldColor,
                  ),
                  style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.inputFieldTextColor,
                    ),
                  ),
                  cursorColor: AppColors.inputFieldTextColor,
                ),
              ),
              if (_showCancelButton)
                TextButton(
                  onPressed: _onCancelSearch,
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.alternativeTextColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        toolbarHeight: 70,
        scrolledUnderElevation: 10,
        shadowColor: Colors.black.withOpacity(.5),
        surfaceTintColor: AppColors.bgColor,
      ),
      body: BlocBuilder<ComicsCubit, ComicsState>(
        builder: (context, state) {
          if (_searchController.text.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(MediaRes.bookIcon),
                    const SizedBox(height: 20),
                    Text(
                      'Start typing to find a particular comic',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.searchTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is SpecificComicsLoading &&
              state.specificComics.isEmpty) {
            return const Center(child: LoadingIndicator());
          } else if (state is SpecificComicsLoaded &&
              state.specificComics.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(MediaRes.magnifyingGlassIcon),
                    const SizedBox(height: 20),
                    Text(
                      'There is no comic book with that name\nin our library. Check the spelling\nand try again.',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.searchTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is SpecificComicsLoaded ||
              state is SpecificComicsLoadingMore) {
            final comics = state is SpecificComicsLoaded
                ? state.specificComics
                : (state as SpecificComicsLoadingMore).specificComics;
            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  comics.length + (state is SpecificComicsLoadingMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < comics.length) {
                  final comic = comics[index];
                  return ComicsTile(comics: comic);
                } else {
                  return const Center(child: LoadingIndicator());
                }
              },
            );
          } else if (state is ComicsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(MediaRes.magnifyingGlassIcon),
                    const SizedBox(height: 20),
                    Text(
                      'There is no comic book with that name\nin our library. Check the spelling\nand try again.',
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: AppColors.searchTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
