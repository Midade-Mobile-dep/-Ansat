class GetAllCategory {
	List<Data>? data;

	GetAllCategory({this.data});

	GetAllCategory.fromJson(Map<String, dynamic> json) {
		if (json['data'] != null) {
			data = <Data>[];
			json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Data {
	int? id;
	String? title;
	String? slug;

	String? enabled;
	int? childrenCount;
	String? thumbnailShowUrl;
	String? smallThumbnail;
	String? mediumThumbnail;
	String? playlistBigThumbnail;
	String? playlistSmallThumbnail;
	String? tagItemsThumbnail;
	String? bigThumbnail;
	String? audioArticlesThumbnail;
	String? quranLibrarynail;

	Data({this.id, this.title, this.slug, this.enabled, this.childrenCount,  this.thumbnailShowUrl, this.smallThumbnail, this.mediumThumbnail, this.playlistBigThumbnail, this.playlistSmallThumbnail, this.tagItemsThumbnail, this.bigThumbnail, this.audioArticlesThumbnail, this.quranLibrarynail});

	Data.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		slug = json['slug'];

		enabled = json['enabled'];
		childrenCount = json['childrenCount'];
		thumbnailShowUrl = json['thumbnail_show_url'];
		smallThumbnail = json['small_thumbnail'];
		mediumThumbnail = json['medium_thumbnail'];
		playlistBigThumbnail = json['playlist_big_thumbnail'];
		playlistSmallThumbnail = json['playlist_small_thumbnail'];
		tagItemsThumbnail = json['tag_items_thumbnail'];
		bigThumbnail = json['big_thumbnail'];
		audioArticlesThumbnail = json['audio_articles_thumbnail'];
		quranLibrarynail = json['quran_librarynail'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data =  Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['slug'] = this.slug;

		data['enabled'] = this.enabled;
		data['childrenCount'] = this.childrenCount;

		data['thumbnail_show_url'] = this.thumbnailShowUrl;
		data['small_thumbnail'] = this.smallThumbnail;
		data['medium_thumbnail'] = this.mediumThumbnail;
		data['playlist_big_thumbnail'] = this.playlistBigThumbnail;
		data['playlist_small_thumbnail'] = this.playlistSmallThumbnail;
		data['tag_items_thumbnail'] = this.tagItemsThumbnail;
		data['big_thumbnail'] = this.bigThumbnail;
		data['audio_articles_thumbnail'] = this.audioArticlesThumbnail;
		data['quran_librarynail'] = this.quranLibrarynail;
		return data;
	}
}

