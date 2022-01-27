import 'dart:convert';

class GetCategoryItems {
  List<Data>? data;

  GetCategoryItems({this.data});

  GetCategoryItems.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
  GetCategoryItems? types;
  Audios? audios;

  String? createdAt;
  String? thumbnailShowUrl;
  GetCategoryItems? authors;
  GetCategoryItems? sources;
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
    types = json['types'] != null
        ? new GetCategoryItems.fromJson(json['types'])
        : null;
    audios =
        json['audios'] != null ? new Audios.fromJson(json['audios']) : null;

    createdAt = json['created_at'];
    thumbnailShowUrl = json['thumbnail_show_url'];
    authors = json['authors'] != null
        ? new GetCategoryItems.fromJson(json['authors'])
        : null;
    sources = json['sources'] != null
        ? new GetCategoryItems.fromJson(json['sources'])
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
  AudioData? audioData;

  Audios({this.audioData});

  Audios.fromJson(Map<String, dynamic> json) {
    audioData = json['data'] != null ? new AudioData.fromJson(json['data']) : null;
  }
}

class AudioData {
  int? id;
  String? type;
  String? link;
  String? embedCode;
  String? file;

  AudioData({this.id, this.type, this.link, this.embedCode, this.file});

  AudioData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    link = json['link'];
    embedCode = json['embed_code'];
    file = json['file'];
  }

  Map<String, dynamic> toJson(AudioData audioData) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['link'] = this.link;
    data['embed_code'] = this.embedCode;
    data['file'] = this.file;
    return data;
  }

  //   static String encode(List<AudioData> AudioDatas) => json.encode(
  //       AudioDatas
  //           .map<Map<String, dynamic>>((AudioData) => AudioData.toJson(AudioData))
  //           .toList(),
  //     );

  // static List<AudioData> decode(String AudioDatas) =>
  //     (json.decode(AudioDatas) as List<dynamic>)
  //         .map<AudioData>((item) => AudioData.fromJson(item))
  //         .toList();
}
