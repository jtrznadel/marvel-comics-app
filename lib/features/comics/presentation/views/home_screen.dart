import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<ComicsCubit, ComicsState>(
      builder: (context, state) {
        if (state is ComicsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ComicsLoaded && state.comics.isEmpty ||
            state is ComicsError) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
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
    );
  }
}
