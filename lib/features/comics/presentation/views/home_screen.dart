import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics_app/core/common/widgets/loading_indicator.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';
import 'package:marvel_comics_app/features/comics/presentation/cubit/comics_cubit.dart';
import 'package:marvel_comics_app/features/comics/presentation/widgets/comics_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ComicsCubit>().getComics();
    super.initState();
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
          } else if (state is ComicsLoaded && state.comics.isEmpty ||
              state is ComicsError) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Comics have not been found',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (state is ComicsLoaded) {
            return ListView.builder(
              itemCount: state.comics.length,
              itemBuilder: (_, index) {
                Comics comics = state.comics[index];
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
