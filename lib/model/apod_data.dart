class ApodData {
  final String title;
  final String url;
  final String mediaType;
  final String desc;
  final String date;
  String note = '';
  bool isFavorite = false;

  ApodData(this.title, this.url, this.mediaType, this.desc, this.date,
      this.note, this.isFavorite);

  ApodData.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        mediaType = json['media_type'],
        url = json['media_type'] == 'image'
            ? json['hdurl']
            : json['thumbnail_url'], // 如果當天的天文資料是影片檔，則取用影片截圖資源
        desc = json['explanation'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'media_type': mediaType,
        'explanation': desc,
        'date': date,
      };
}
