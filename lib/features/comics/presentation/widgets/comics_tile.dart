import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marvel_comics_app/core/res/app_colors.dart';
import 'package:marvel_comics_app/core/res/media_res.dart';
import 'package:marvel_comics_app/features/comics/data/models/comics_model.dart';
import 'package:marvel_comics_app/features/comics/domain/entities/comics.dart';

class ComicsTile extends StatelessWidget {
  const ComicsTile({super.key, required this.comics});

  final Comics comics;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final writer = comics.creators.firstWhere(
      (creator) => creator.role.toLowerCase() == 'writer',
      orElse: () => const CreatorModel(name: 'Unknown', role: 'writer'),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20)
          .copyWith(bottom: 0),
      child: Container(
        width: size.width,
        height: size.height * .24,
        decoration: BoxDecoration(
          color: AppColors.bgColor,
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 6),
              blurRadius: 24,
              color: Colors.black.withOpacity(.2),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              child: comics.images.isNotEmpty
                  ? Image.network(comics.images.first)
                  : Image.asset(
                      MediaRes.comicsPlaceholderCoverImages,
                      fit: BoxFit.fitHeight,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          comics.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                        Text(
                          'written by ${writer.name}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              color: AppColors.alternativeTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      comics.description,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
