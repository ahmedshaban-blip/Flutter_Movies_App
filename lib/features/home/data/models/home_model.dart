class Movie {
  final int id;
  final String title;
  final String overview;
  final double popularity;
  final double vote_average;
  final double vote_count;
  final String release_date;
  final String poster_path;

  Movie(this.id, this.title, this.overview, this.popularity, this.vote_average,
      this.vote_count, this.release_date, this.poster_path);

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      json['id'],
      json['title'],
      json['overview'],
      (json['popularity'] as num).toDouble(),
      (json['vote_average'] as num).toDouble(),
      (json['vote_count'] as num).toDouble(),
      json['release_date'],
      json['poster_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'popularity': popularity,
      'vote_average': vote_average,
      'vote_count': vote_count,
      'release_date': release_date,
      'poster_path': poster_path,
    };
  }
}
