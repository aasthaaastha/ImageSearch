class Images {
  String title, openingCrawl, director, producer;
  DateTime releaseDate;

  Images({
    this.title,
    this.openingCrawl,
    this.director,
    this.producer,
    this.releaseDate,
  });

  Images.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    openingCrawl = map['opening_crawl'];
    director = map['director'];
    producer = map['producer'];
    releaseDate = DateTime.parse(map['release_date']);
  }
}