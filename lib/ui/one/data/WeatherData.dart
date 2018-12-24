class WeatherData {
  Data data;

  WeatherData({this.data});

  WeatherData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Date date;
  String author;
  String title;
  String digest;
  String content;
  int wc;

  Data(
      {this.date, this.author, this.title, this.digest, this.content, this.wc});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'] != null ? new Date.fromJson(json['date']) : null;
    author = json['author'];
    title = json['title'];
    digest = json['digest'];
    content = json['content'];
    wc = json['wc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.date != null) {
      data['date'] = this.date.toJson();
    }
    data['author'] = this.author;
    data['title'] = this.title;
    data['digest'] = this.digest;
    data['content'] = this.content;
    data['wc'] = this.wc;
    return data;
  }
}

class Date {
  String curr;
  String prev;
  String next;

  Date({this.curr, this.prev, this.next});

  Date.fromJson(Map<String, dynamic> json) {
    curr = json['curr'];
    prev = json['prev'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['curr'] = this.curr;
    data['prev'] = this.prev;
    data['next'] = this.next;
    return data;
  }
}