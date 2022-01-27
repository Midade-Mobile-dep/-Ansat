class SearchModel {
  List<Data>? data;

  SearchModel({this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  String? title;
  String? slug;
  String? description;
  int? views;
  SearchModel? types;
  Audios? audios;

  String? createdAt;
  String? thumbnailShowUrl;
  SearchModel? authors;
  SearchModel? sources;
  String? smallThumbnail;
  String? mediumThumbnail;
  String? playlistBigThumbnail;
  String? playlistSmallThumbnail;
  String? tagItemsThumbnail;
  String? bigThumbnail;
  String? audioArticlesThumbnail;
  String? quranLibrarynail;
  String? audiosUrl;

  Data(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.views,
      this.types,
      this.audios,
      this.createdAt,
      this.thumbnailShowUrl,
      this.authors,
      this.sources,
      this.smallThumbnail,
      this.mediumThumbnail,
      this.playlistBigThumbnail,
      this.playlistSmallThumbnail,
      this.tagItemsThumbnail,
      this.bigThumbnail,
      this.audioArticlesThumbnail,
      this.quranLibrarynail,
      this.audiosUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    views = json['views'];
    types =
        json['types'] != null ? new SearchModel.fromJson(json['types']) : null;
    audios =
        json['audios'] != null ? new Audios.fromJson(json['audios']) : null;

    createdAt = json['created_at'];
    thumbnailShowUrl = json['thumbnail_show_url'];
    authors = json['authors'] != null
        ? new SearchModel.fromJson(json['authors'])
        : null;
    sources = json['sources'] != null
        ? new SearchModel.fromJson(json['sources'])
        : null;
    smallThumbnail = json['small_thumbnail'];
    mediumThumbnail = json['medium_thumbnail'];
    playlistBigThumbnail = json['playlist_big_thumbnail'];
    playlistSmallThumbnail = json['playlist_small_thumbnail'];
    tagItemsThumbnail = json['tag_items_thumbnail'];
    bigThumbnail = json['big_thumbnail'];
    audioArticlesThumbnail = json['audio_articles_thumbnail'];
    quranLibrarynail = json['quran_librarynail'];
    audiosUrl = json['audios_url'];
  }
}

class Audios {
  AudioDtata? data;

  Audios({this.data});

  Audios.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new AudioDtata.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AudioDtata {
  int? id;
  String? type;
  String? link;
  String? embedCode;
  Null? file;

  AudioDtata({this.id, this.type, this.link, this.embedCode, this.file});

  AudioDtata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    link = json['link'];
    embedCode = json['embed_code'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['link'] = this.link;
    data['embed_code'] = this.embedCode;
    data['file'] = this.file;
    return data;
  }
}
