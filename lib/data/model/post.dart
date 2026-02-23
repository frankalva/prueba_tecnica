// Modelo de Post obtenido desde la API REST de JSONPlaceholder.
// En un contexto eCommerce, este modelo representaria un producto
// o una publicacion dentro de un marketplace, con campos como
// userId (vendedor), title (nombre del producto) y body (descripcion).
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        userId: json['userId'] as int,
        id: json['id'] as int,
        title: json['title'] as String,
        body: json['body'] as String,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
