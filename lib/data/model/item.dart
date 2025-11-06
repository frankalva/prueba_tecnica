class Item {
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Item({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    this.url = '',
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json['id'],
    title: json['title'],
    url: json['url'],
    thumbnailUrl: json['thumbnailUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'thumbnailUrl': thumbnailUrl,
    'url': url,
  };
}
