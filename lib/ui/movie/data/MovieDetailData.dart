class MovieDetailData {
  Rating rating;
  int reviewsCount;
  int wishCount;
  String doubanSite;
  String year;
  Images images;
  String alt;
  String id;
  String mobileUrl;
  String title;
  Null doCount;
  String shareUrl;
  Null seasonsCount;
  String scheduleUrl;
  Null episodesCount;
  List<String> countries;
  List<String> genres;
  int collectCount;
  List<Casts> casts;
  Null currentSeason;
  String originalTitle;
  String summary;
  String subtype;
  List<Directors> directors;
  int commentsCount;
  int ratingsCount;
  List<String> aka;

  MovieDetailData(
      {this.rating,
        this.reviewsCount,
        this.wishCount,
        this.doubanSite,
        this.year,
        this.images,
        this.alt,
        this.id,
        this.mobileUrl,
        this.title,
        this.doCount,
        this.shareUrl,
        this.seasonsCount,
        this.scheduleUrl,
        this.episodesCount,
        this.countries,
        this.genres,
        this.collectCount,
        this.casts,
        this.currentSeason,
        this.originalTitle,
        this.summary,
        this.subtype,
        this.directors,
        this.commentsCount,
        this.ratingsCount,
        this.aka});

  MovieDetailData.fromJson(Map<String, dynamic> json) {
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    reviewsCount = json['reviews_count'];
    wishCount = json['wish_count'];
    doubanSite = json['douban_site'];
    year = json['year'];
    images =
    json['images'] != null ? new Images.fromJson(json['images']) : null;
    alt = json['alt'];
    id = json['id'];
    mobileUrl = json['mobile_url'];
    title = json['title'];
    doCount = json['do_count'];
    shareUrl = json['share_url'];
    seasonsCount = json['seasons_count'];
    scheduleUrl = json['schedule_url'];
    episodesCount = json['episodes_count'];
    countries = json['countries'].cast<String>();
    genres = json['genres'].cast<String>();
    collectCount = json['collect_count'];
    if (json['casts'] != null) {
      casts = new List<Casts>();
      json['casts'].forEach((v) {
        casts.add(new Casts.fromJson(v));
      });
    }
    currentSeason = json['current_season'];
    originalTitle = json['original_title'];
    summary = json['summary'];
    subtype = json['subtype'];
    if (json['directors'] != null) {
      directors = new List<Directors>();
      json['directors'].forEach((v) {
        directors.add(new Directors.fromJson(v));
      });
    }
    commentsCount = json['comments_count'];
    ratingsCount = json['ratings_count'];
    aka = json['aka'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['reviews_count'] = this.reviewsCount;
    data['wish_count'] = this.wishCount;
    data['douban_site'] = this.doubanSite;
    data['year'] = this.year;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['alt'] = this.alt;
    data['id'] = this.id;
    data['mobile_url'] = this.mobileUrl;
    data['title'] = this.title;
    data['do_count'] = this.doCount;
    data['share_url'] = this.shareUrl;
    data['seasons_count'] = this.seasonsCount;
    data['schedule_url'] = this.scheduleUrl;
    data['episodes_count'] = this.episodesCount;
    data['countries'] = this.countries;
    data['genres'] = this.genres;
    data['collect_count'] = this.collectCount;
    if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
    data['current_season'] = this.currentSeason;
    data['original_title'] = this.originalTitle;
    data['summary'] = this.summary;
    data['subtype'] = this.subtype;
    if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
    data['comments_count'] = this.commentsCount;
    data['ratings_count'] = this.ratingsCount;
    data['aka'] = this.aka;
    return data;
  }
}

class Rating {
  int max;
  double average;
  String stars;
  int min;

  Rating({this.max, this.average, this.stars, this.min});

  Rating.fromJson(Map<String, dynamic> json) {
    max = json['max'];
    average = json['average'];
    stars = json['stars'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max'] = this.max;
    data['average'] = this.average;
    data['stars'] = this.stars;
    data['min'] = this.min;
    return data;
  }
}

class Images {
  String small;
  String large;
  String medium;

  Images({this.small, this.large, this.medium});

  Images.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class Casts {
  String alt;
  Avatars avatars;
  String name;
  String id;

  Casts({this.alt, this.avatars, this.name, this.id});

  Casts.fromJson(Map<String, dynamic> json) {
    alt = json['alt'];
    avatars =
    json['avatars'] != null ? new Avatars.fromJson(json['avatars']) : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alt'] = this.alt;
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}

class Avatars {
  String small;
  String large;
  String medium;

  Avatars({this.small, this.large, this.medium});

  Avatars.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['small'] = this.small;
    data['large'] = this.large;
    data['medium'] = this.medium;
    return data;
  }
}

class Directors {
  String alt;
  Avatars avatars;
  String name;
  String id;

  Directors({this.alt, this.avatars, this.name, this.id});

  Directors.fromJson(Map<String, dynamic> json) {
    alt = json['alt'];
    avatars =
    json['avatars'] != null ? new Avatars.fromJson(json['avatars']) : null;
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alt'] = this.alt;
    if (this.avatars != null) {
      data['avatars'] = this.avatars.toJson();
    }
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
