

class OneDetail {
  int res;
  Data data;

  OneDetail({this.res, this.data});

  OneDetail.fromJson(Map<String, dynamic> json) {
    res = json['res'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res'] = this.res;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String id;
  Weather weather;
  String date;
  List<ContentList> contentList;

  Data({this.id, this.weather, this.date, this.contentList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weather = json['weather'] != null ? new Weather.fromJson(json['weather']) : null;
    date = json['date'];
    if (json['content_list'] != null) {
      contentList = new List<ContentList>();
      json['content_list'].forEach((v) { contentList.add(new ContentList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.weather != null) {
      data['weather'] = this.weather.toJson();
    }
    data['date'] = this.date;
    if (this.contentList != null) {
      data['content_list'] = this.contentList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Weather {
  String cityName;
  String date;
  String temperature;
  String humidity;
  String climate;
  String windDirection;
  String hurricane;
  Icons icons;

  Weather({this.cityName, this.date, this.temperature, this.humidity, this.climate, this.windDirection, this.hurricane, this.icons});

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json['city_name'];
    date = json['date'];
    temperature = json['temperature'];
    humidity = json['humidity'];
    climate = json['climate'];
    windDirection = json['wind_direction'];
    hurricane = json['hurricane'];
    icons = json['icons'] != null ? new Icons.fromJson(json['icons']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.cityName;
    data['date'] = this.date;
    data['temperature'] = this.temperature;
    data['humidity'] = this.humidity;
    data['climate'] = this.climate;
    data['wind_direction'] = this.windDirection;
    data['hurricane'] = this.hurricane;
    if (this.icons != null) {
      data['icons'] = this.icons.toJson();
    }
    return data;
  }
}

class Icons {
  String day;
  String night;

  Icons({this.day, this.night});

  Icons.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    night = json['night'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['night'] = this.night;
    return data;
  }
}

class ContentList {
  String id;
  String category;
  String displayCategory;
  String itemId;
  String title;
  String forward;
  String imgUrl;
  int likeCount;
  String postDate;
  String lastUpdateDate;
  String videoUrl;
  String audioUrl;
  int audioPlatform;
  String startVideo;
  int hasReading;
  String volume;
  String picInfo;
  String wordsInfo;
  String subtitle;
  int number;
  int serialId;
  int movieStoryId;
  int adId;
  int adType;
  String adPvurl;
  String adLinkurl;
  String adMakettime;
  String adClosetime;
  String adShareCnt;
  String adPvurlVendor;
  String contentId;
  String contentType;
  String contentBgcolor;
  String shareUrl;
  ShareInfo shareInfo;
  ShareList shareList;

  ContentList({this.id, this.category, this.displayCategory, this.itemId, this.title, this.forward, this.imgUrl, this.likeCount, this.postDate, this.lastUpdateDate, this.videoUrl, this.audioUrl, this.audioPlatform, this.startVideo, this.hasReading, this.volume, this.picInfo, this.wordsInfo, this.subtitle, this.number, this.serialId, this.movieStoryId, this.adId, this.adType, this.adPvurl, this.adLinkurl, this.adMakettime, this.adClosetime, this.adShareCnt, this.adPvurlVendor, this.contentId, this.contentType, this.contentBgcolor, this.shareUrl, this.shareInfo, this.shareList});

  ContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    displayCategory = json['display_category'];
    itemId = json['item_id'];
    title = json['title'];
    forward = json['forward'];
    imgUrl = json['img_url'];
    likeCount = json['like_count'];
    postDate = json['post_date'];
    lastUpdateDate = json['last_update_date'];
    videoUrl = json['video_url'];
    audioUrl = json['audio_url'];
    audioPlatform = json['audio_platform'];
    startVideo = json['start_video'];
    hasReading = json['has_reading'];
    volume = json['volume'];
    picInfo = json['pic_info'];
    wordsInfo = json['words_info'];
    subtitle = json['subtitle'];
    number = json['number'];
    serialId = json['serial_id'];
    movieStoryId = json['movie_story_id'];
    adId = json['ad_id'];
    adType = json['ad_type'];
    adPvurl = json['ad_pvurl'];
    adLinkurl = json['ad_linkurl'];
    adMakettime = json['ad_makettime'];
    adClosetime = json['ad_closetime'];
    adShareCnt = json['ad_share_cnt'];
    adPvurlVendor = json['ad_pvurl_vendor'];
    contentId = json['content_id'];
    contentType = json['content_type'];
    contentBgcolor = json['content_bgcolor'];
    shareUrl = json['share_url'];
    shareInfo = json['share_info'] != null ? new ShareInfo.fromJson(json['share_info']) : null;
    shareList = json['share_list'] != null ? new ShareList.fromJson(json['share_list']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['display_category'] = this.displayCategory;
    data['item_id'] = this.itemId;
    data['title'] = this.title;
    data['forward'] = this.forward;
    data['img_url'] = this.imgUrl;
    data['like_count'] = this.likeCount;
    data['post_date'] = this.postDate;
    data['last_update_date'] = this.lastUpdateDate;
    data['video_url'] = this.videoUrl;
    data['audio_url'] = this.audioUrl;
    data['audio_platform'] = this.audioPlatform;
    data['start_video'] = this.startVideo;
    data['has_reading'] = this.hasReading;
    data['volume'] = this.volume;
    data['pic_info'] = this.picInfo;
    data['words_info'] = this.wordsInfo;
    data['subtitle'] = this.subtitle;
    data['number'] = this.number;
    data['serial_id'] = this.serialId;
    data['movie_story_id'] = this.movieStoryId;
    data['ad_id'] = this.adId;
    data['ad_type'] = this.adType;
    data['ad_pvurl'] = this.adPvurl;
    data['ad_linkurl'] = this.adLinkurl;
    data['ad_makettime'] = this.adMakettime;
    data['ad_closetime'] = this.adClosetime;
    data['ad_share_cnt'] = this.adShareCnt;
    data['ad_pvurl_vendor'] = this.adPvurlVendor;
    data['content_id'] = this.contentId;
    data['content_type'] = this.contentType;
    data['content_bgcolor'] = this.contentBgcolor;
    data['share_url'] = this.shareUrl;
    if (this.shareInfo != null) {
      data['share_info'] = this.shareInfo.toJson();
    }
    if (this.shareList != null) {
      data['share_list'] = this.shareList.toJson();
    }

    return data;
  }
}



class ShareInfo {
  String url;
  String image;
  String title;
  String content;

  ShareInfo({this.url, this.image, this.title, this.content});

  ShareInfo.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    image = json['image'];
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['image'] = this.image;
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class ShareList {
  Wx wx;
  WxTimeline wxTimeline;
  Weibo weibo;
  Qq qq;

  ShareList({this.wx, this.wxTimeline, this.weibo, this.qq});

  ShareList.fromJson(Map<String, dynamic> json) {
    wx = json['wx'] != null ? new Wx.fromJson(json['wx']) : null;
    wxTimeline = json['wx_timeline'] != null ? new WxTimeline.fromJson(json['wx_timeline']) : null;
    weibo = json['weibo'] != null ? new Weibo.fromJson(json['weibo']) : null;
    qq = json['qq'] != null ? new Qq.fromJson(json['qq']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.wx != null) {
      data['wx'] = this.wx.toJson();
    }
    if (this.wxTimeline != null) {
      data['wx_timeline'] = this.wxTimeline.toJson();
    }
    if (this.weibo != null) {
      data['weibo'] = this.weibo.toJson();
    }
    if (this.qq != null) {
      data['qq'] = this.qq.toJson();
    }
    return data;
  }
}

class Wx {
  String title;
  String desc;
  String link;
  String imgUrl;
  String audio;

  Wx({this.title, this.desc, this.link, this.imgUrl, this.audio});

  Wx.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    link = json['link'];
    imgUrl = json['imgUrl'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['link'] = this.link;
    data['imgUrl'] = this.imgUrl;
    data['audio'] = this.audio;
    return data;
  }
}

class WxTimeline {
  String title;
  String desc;
  String link;
  String imgUrl;
  String audio;

  WxTimeline({this.title, this.desc, this.link, this.imgUrl, this.audio});

  WxTimeline.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    link = json['link'];
    imgUrl = json['imgUrl'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['link'] = this.link;
    data['imgUrl'] = this.imgUrl;
    data['audio'] = this.audio;
    return data;
  }
}

class Weibo {
  String title;
  String desc;
  String link;
  String imgUrl;
  String audio;

  Weibo({this.title, this.desc, this.link, this.imgUrl, this.audio});

  Weibo.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    link = json['link'];
    imgUrl = json['imgUrl'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['link'] = this.link;
    data['imgUrl'] = this.imgUrl;
    data['audio'] = this.audio;
    return data;
  }
}

class Qq {
  String title;
  String desc;
  String link;
  String imgUrl;
  String audio;

  Qq({this.title, this.desc, this.link, this.imgUrl, this.audio});

  Qq.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    link = json['link'];
    imgUrl = json['imgUrl'];
    audio = json['audio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['link'] = this.link;
    data['imgUrl'] = this.imgUrl;
    data['audio'] = this.audio;
    return data;
  }
}

class Menu {
  String vol;

  Menu({this.vol});

  Menu.fromJson(Map<String, dynamic> json) {
    vol = json['vol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vol'] = this.vol;
    return data;
  }
}

class Tag {
  String id;
  String title;

  Tag({this.id, this.title});

  Tag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
