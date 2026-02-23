// Constantes de la API REST utilizada en el proyecto.
// En un contexto eCommerce, estas constantes centralizan las URLs
// del backend, facilitando el mantenimiento y cambio de entornos
// (desarrollo, staging, produccion).
class ConstansApi {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const String photosEndpoint = '/photos';
  static const String postsEndpoint = '/posts';
  static const Duration timeout = Duration(seconds: 10);
}