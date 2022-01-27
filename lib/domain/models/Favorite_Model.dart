class FavoriteModel {
  int? id;
  String? title;
  String? slug;
  String? description;
  int? views;
  Audios? audios;

  String? createdAt;
  String? thumbnailShowUrl;

  String? smallThumbnail;
  String? mediumThumbnail;
  String? playlistBigThumbnail;
  String? playlistSmallThumbnail;
  String? tagItemsThumbnail;
  String? bigThumbnail;
  String? audioArticlesThumbnail;
  String? quranLibrarynail;
  String? audiosUrl;

  FavoriteModel(
      {this.id,
      this.title,
      this.slug,
      this.description,
      this.views,
      this.audios,
      this.createdAt,
      this.thumbnailShowUrl,

      this.smallThumbnail,
      this.mediumThumbnail,
      this.playlistBigThumbnail,
      this.playlistSmallThumbnail,
      this.tagItemsThumbnail,
      this.bigThumbnail,
      this.audioArticlesThumbnail,
      this.quranLibrarynail,
      this.audiosUrl});
}


class Audios {
  AudioData? audioData;

  Audios({this.audioData});


}

class AudioData {
  int? id;
  String? type;
  String? link;
  String? embedCode;

  AudioData({
    this.id,
    this.type,
    this.link,
    this.embedCode,
  });



}