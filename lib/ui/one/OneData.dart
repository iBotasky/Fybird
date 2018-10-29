class OneData {
  int res;
  Data data;

  OneData({this.res, this.data});

  OneData.fromJson(Map<String, dynamic> json) {
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
  String date;
  List<ContentList> contentList;

  Data({this.id, this.date, this.contentList});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    if (json['content_list'] != null) {
      contentList = new List<ContentList>();
      json['content_list'].forEach((v) { contentList.add(new ContentList.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    if (this.contentList != null) {
      data['content_list'] = this.contentList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ContentList {
  String id;
  String itemId;
  String title;
  String forward;
  String imgUrl;
  int likeCount;
  String postDate;
  String lastUpdateDate;
  int audioPlatform;
  String startVideo;
  String volume;
  String picInfo;
  String wordsInfo;
  String subtitle;
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

  ContentList({this.id, this.itemId, this.title, this.forward, this.imgUrl, this.likeCount, this.postDate, this.lastUpdateDate,  this.audioPlatform, this.startVideo, this.volume, this.picInfo, this.wordsInfo, this.subtitle, this.adId, this.adType, this.adPvurl, this.adLinkurl, this.adMakettime, this.adClosetime, this.adShareCnt, this.adPvurlVendor, this.contentId, this.contentType, this.contentBgcolor});

  ContentList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    title = json['title'];
    forward = json['forward'];
    imgUrl = json['img_url'];
    likeCount = json['like_count'];
    postDate = json['post_date'];
    lastUpdateDate = json['last_update_date'];
    audioPlatform = json['audio_platform'];
    startVideo = json['start_video'];
    volume = json['volume'] is int ? json['volume'].toString() : json['volume'];
    picInfo = json['pic_info'];
    wordsInfo = json['words_info'];
    subtitle = json['subtitle'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['title'] = this.title;
    data['forward'] = this.forward;
    data['img_url'] = this.imgUrl;
    data['like_count'] = this.likeCount;
    data['post_date'] = this.postDate;
    data['last_update_date'] = this.lastUpdateDate;
    data['audio_platform'] = this.audioPlatform;
    data['start_video'] = this.startVideo;
    data['volume'] = this.volume;
    data['pic_info'] = this.picInfo;
    data['words_info'] = this.wordsInfo;
    data['subtitle'] = this.subtitle;
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
    return data;
  }
}
