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
  bool _showCancelButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _showCancelButton = _searchController.text.isNotEmpty;
    });
    String query =
        _searchController.text != '' ? _searchController.text : '_empty_';
    context.read<ComicsCubit>().getSpecificComics(query);
  }

  void _onCancelSearch() {
    _searchController.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      _showCancelButton = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Start typing to find a particular comics',
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
          } else if (state is SpecificComicsLoading) {
            return const Center(child: LoadingIndicator());
          } else if (state is SpecificComicsLoaded &&
                  state.specificComics.isEmpty ||
              state is ComicsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(MediaRes.magnifyingGlassIcon),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'There is no comic book with that name \nin our library. Check the spelling \nand try again.',
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
          } else if (state is SpecificComicsLoaded) {
            return ListView.builder(
              itemCount: state.specificComics.length,
              itemBuilder: (_, index) {
                Comics comics = state.specificComics[index];
                return ComicsTile(
                  comics: comics,
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
