import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theme/app_colors.dart';
import 'package:movie_app/features/favorite/presentation/pages/shared_pref.dart';
import 'package:movie_app/features/home/data/models/home_model.dart';
import '../cubit/details_cubit.dart';
import '../cubit/details_state.dart';

class DetailsPage extends StatelessWidget {
  final Movie movie;
  DetailsPage({super.key, required this.movie});

  final SharedPref sharedPref = SharedPref();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final gradients = Theme.of(context).extension<AppGradients>()!;
    final semantic = Theme.of(context).extension<AppSemanticColors>()!;

    return BlocProvider(
      create: (_) => DetailsCubit(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradients.bgGradient,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: scheme.onSurface.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.arrow_back, color: scheme.onSurface),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: scheme.onSurface.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () => sharedPref.addToFav(movie),
                    child: Icon(Icons.bookmark_border, color: scheme.onSurface),
                  ),
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(color: scheme.primary),
                );
              } else if (state is DetailsFailure) {
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                    style: textTheme.bodyMedium
                        ?.copyWith(color: scheme.onBackground),
                  ),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: 'movie-${movie.id}',
                          child: Container(
                            height: 500,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.poster_path}',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    scheme.scrim.withOpacity(0.7),
                                    scheme.background.withOpacity(0.95),
                                  ],
                                  stops: const [0.0, 0.7, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: _ratingColor(movie.vote_average, semantic)
                                  .withOpacity(0.95),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      _ratingColor(movie.vote_average, semantic)
                                          .withOpacity(0.4),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.white, size: 20),
                                const SizedBox(width: 6),
                                Text(
                                  movie.vote_average.toStringAsFixed(1),
                                  style: textTheme.titleSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            movie.title,
                            style: textTheme.headlineSmall?.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.bold,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),

                          Row(
                            children: [
                              _buildInfoChip(context,
                                  icon: Icons.calendar_today,
                                  label: movie.release_date.substring(0, 4)),
                              const SizedBox(width: 10),
                              _buildInfoChip(context,
                                  icon: Icons.trending_up,
                                  label: movie.popularity.toInt().toString()),
                              const SizedBox(width: 10),
                              _buildInfoChip(context,
                                  icon: Icons.people,
                                  label: '${movie.vote_count.toInt()} votes'),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              ...List.generate(5, (index) {
                                final rating = movie.vote_average / 2;
                                if (index < rating.floor()) {
                                  return Icon(Icons.star,
                                      color: scheme.primary, size: 24);
                                } else if (index < rating) {
                                  return Icon(Icons.star_half,
                                      color: scheme.primary, size: 24);
                                } else {
                                  return Icon(Icons.star_border,
                                      color: scheme.onSurface.withOpacity(0.4),
                                      size: 24);
                                }
                              }),
                              const SizedBox(width: 8),
                              Text(
                                '${movie.vote_average.toStringAsFixed(1)}/10',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: scheme.onSurface.withOpacity(0.6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Divider
                          Divider(color: scheme.outlineVariant, thickness: 1),
                          const SizedBox(height: 20),

                          // Overview Section
                          Text(
                            'Overview',
                            style: textTheme.titleLarge?.copyWith(
                              color: scheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            movie.overview.isNotEmpty
                                ? movie.overview
                                : 'No overview available for this movie.',
                            style: textTheme.bodyLarge?.copyWith(
                              color: scheme.onSurface.withOpacity(0.75),
                              height: 1.6,
                              letterSpacing: 0.3,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          const SizedBox(height: 30),

                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text('Watch Trailer'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: scheme.primary,
                                    foregroundColor: scheme.onPrimary,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    elevation: 5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: scheme.onSurface,
                                  backgroundColor:
                                      scheme.surface.withOpacity(0.12),
                                  side: BorderSide(
                                      color: scheme.onSurface.withOpacity(0.3)),
                                  padding: const EdgeInsets.all(16),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: const Icon(Icons.share),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context,
      {required IconData icon, required String label}) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: scheme.onSurface.withOpacity(0.2), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: scheme.primary, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              color: scheme.onSurface,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Color _ratingColor(double rating, AppSemanticColors semantic) {
    if (rating >= 8.0) return semantic.ratingHigh;
    if (rating >= 6.0) return semantic.ratingMid;
    return semantic.ratingLow;
  }
}
