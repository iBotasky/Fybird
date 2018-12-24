class MovieData {
  int count;
  int start;
  int total;
  List<Subjects> subjects;
  String title;

  MovieData({this.count, this.start, this.total, this.subjects, this.title});

  MovieData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    start = json['start'];
    total = json['total'];
    if (json['subjects'] != null) {
      subjects = new List<Subjects>();
      json['subjects'].forEach((v) {
        subjects.add(new Subjects.fromJson(v));
      });
    }
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['start'] = this.start;
    data['total'] = this.total;
    if (this.subjects != null) {
      data['subjects'] = this.subjects.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    return data;
  }
}

class Subjects {
  Rating rating;
  List<String> genres;
  String title;
  List<Casts> casts;
  int collectCount;
  String originalTitle;
  String subtype;
  List<Directors> directors;
  String year;
  Images images;
  String alt;
  String id;

  Subjects(
      {this.rating,
      this.genres,
      this.title,
      this.casts,
      this.collectCount,
      this.originalTitle,
      this.subtype,
      this.directors,
      this.year,
      this.images,
      this.alt,
      this.id});

  Subjects.fromJson(Map<String, dynamic> json) {
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    genres = json['genres'].cast<String>();
    title = json['title'];
    if (json['casts'] != null) {
      casts = new List<Casts>();
      json['casts'].forEach((v) {
        casts.add(new Casts.fromJson(v));
      });
    }
    collectCount = json['collect_count'];
    originalTitle = json['original_title'];
    subtype = json['subtype'];
    if (json['directors'] != null) {
      directors = new List<Directors>();
      json['directors'].forEach((v) {
        directors.add(new Directors.fromJson(v));
      });
    }
    year = json['year'];
    images =
        json['images'] != null ? new Images.fromJson(json['images']) : null;
    alt = json['alt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.rating != null) {
      data['rating'] = this.rating.toJson();
    }
    data['genres'] = this.genres;
    data['title'] = this.title;
    if (this.casts != null) {
      data['casts'] = this.casts.map((v) => v.toJson()).toList();
    }
    data['collect_count'] = this.collectCount;
    data['original_title'] = this.originalTitle;
    data['subtype'] = this.subtype;
    if (this.directors != null) {
      data['directors'] = this.directors.map((v) => v.toJson()).toList();
    }
    data['year'] = this.year;
    if (this.images != null) {
      data['images'] = this.images.toJson();
    }
    data['alt'] = this.alt;
    data['id'] = this.id;
    return data;
  }

  String getGenres() {
    String string = "";
    for (String s in genres) {
      string += s + "/";
    }
    return string.substring(0, string.length - 1);
  }

  String getDirectors() {
    String string = "";
    for (Directors s in directors) {
      string += "        " +s.name + "\n";
    }
    return string.substring(8, string.length - 1);
  }

  String getFirstThreeCasts() {
    String string = "";
    for (Casts s in casts) {
      string += "          " + s.name + "\n";
    }
    return string == "" ? "" : string.substring(9, string.length - 1);
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
    average = json['average'] * 1.0;
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
