class NewsModel {
  // final String uuid;
  final String title;
  final String description;
  final String date;
  final String? image;
  final String content;
  final String source;

  const NewsModel({
    // required this.uuid,
    required this.title,
    required this.description,
    required this.date,
    required this.image,
    required this.content,
    required this.source,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    print('JSON Data: $json');
    return NewsModel(
      // uuid: json['uuid'],
      title: json['title'] ?? 'No title',
      description: json['description'] ?? 'No description',
      date: json['publishedAt'] ?? '2024-09-27T09:00:00Z',
      image: json['urlToImage'] != null && json['urlToImage'].isNotEmpty
          ? json['urlToImage']
          : "https://imgs.hipertextual.com/wp-content/uploads/2021/03/olga-kononenko-98__mskausi-unsplash-scaled.jpeg",
      content: json['content'] ?? 'No content',
      source: json['url'] ?? 'No source',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      'image': image,
      'content': content,
      'source': source,
    };
  }
}
