# Flutter eCommerce Posts - Prueba Tecnica Expertis 

Aplicacion Flutter que muestra un listado de posts con buscador, pantalla de detalle con comentarios obtenidos desde plataforma nativa (iOS/Android), funcionalidad de "like" con persistencia local, simulando en un contexto cercano a una aplicacion de eCommerce real


### Pantallas Principales

1. **Listado de Posts** (`/posts`) - Catalogo de posts con buscador, indicador de likes, y navegacion al detalle
2. **Detalle de Post** (`/post/:id`) - Informacion completa del post, boton de like/dislike, y listado de comentarios cargados via plataforma nativa

### Flujos Implementados

- Consumo de posts desde Flutter (Dio + API REST)
- Obtencion de comentarios desde plataforma nativa (Swift/Kotlin via MethodChannel)
- Busqueda de posts con debounce para optimizar rendimiento
- Like/dislike de posts con persistencia local (SharedPreferences)
- Manejo de estados: loading, error con retry, empty state
- Navegacion declarativa con GoRouter

## Arquitectura

Se utiliza **Clean Architecture** con separacion en capas:

```
lib/
+-- core/           # constantes, errores y utilidades transversales
+-- data/           # modelos, servicios y repositorios
|   +-- model/      # entidades (post, comment)
|   +-- sources/    # fuentes de datos (API, nativo, local)
|   +-- repositories/ # repositorios que abstraen los servicios
+-- domain/         # capa de dominio
+-- presentation/   # capa de presentacion
    +-- cubits/     # manejo de estado con BLoC/Cubit
    +-- routes/     # enrutamiento declarativo
    +-- screens/    # pantallas de la aplicacion
    +-- widgets/    # widgets reutilizables
```

### Patron de Estado

- **PostCubit**: Gestiona la carga de posts desde la API REST
- **CommentCubit**: Gestiona la carga de comentarios via Platform Channel (nativo)
- **LikeCubit**: Gestiona los likes con persistencia local (SharedPreferences)

### Obtencion de Comentarios (Nativo)

Los comentarios se obtienen desde el lado nativo de cada plataforma:
- **iOS**: `AppDelegate.swift` con `URLSession` y `FlutterMethodChannel`
- **Android**: `MainActivity.kt` con `HttpURLConnection` y `MethodChannel`

El puente desde Flutter se realiza a traves de `CommentNativeService` usando `MethodChannel`.

## Dependencias

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_bloc: ^9.1.1
  hive_flutter: ^1.1.0
  hive: ^2.2.3
  path_provider: ^2.0.15
  equatable: ^2.0.7
  dio: ^5.1.1
  go_router: ^16.3.0
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  build_runner: ^2.4.6
  hive_generator: ^2.0.1
  bloc_test: ^10.0.0
  mocktail: ^1.0.4
flutter:
  uses-material-design: true    
```

## Pasos para Correr el Proyecto

### 1. Clonar el repositorio
```bash
git clone <url-del-repositorio>
cd flutter_application_1
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Generar archivos de codigo (adaptadores Hive)
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Ejecutar la aplicacion
```bash
flutter run
```

### 5. Ejecutar tests
```bash
flutter test
```

## Decisiones Tecnicas

1. **Posts desde Flutter, Comentarios desde nativo**: Se cumplio el requerimiento de obtener posts via Dio en Flutter y comentarios via llamadas HTTP nativas en Swift (URLSession) y Kotlin (HttpURLConnection), comunicados a traves de Platform Channels

2. **SharedPreferences para likes**: Se eligio SharedPreferences por su simplicidad para almacenar un Set de IDs y debido a que esto es una prueba tecnica no requeria usar algo mas complejo si no fuera a gran escala. En un escenario real de eCommerce con lista de deseos mas compleja, se podria migrar a Hive o SQLite

3. **Debounce en buscador**: Evita llamadas excesivas al filtrado, mejorando el rendimiento en listas grandes

4. **CommentCubit local por pantalla**: El cubit de comentarios se crea a nivel de la pantalla de detalle (no global), ya que los comentarios son especificos de cada post y se liberan al salir

5. **Manejo de errores con retry**: Tanto la lista de posts como los comentarios manejan errores de red con boton de reintento

6. **Tests enfocados en likes**: Se implementaron unit tests simples y directos solo para la funcionalidad de likes (LikeLocalService, LikeRepository, LikeCubit) con SharedPreferences real en memoria. Se usa `bloc_test` para verificar transiciones de estado reales y `SharedPreferences.setMockInitialValues()` para controlar limites externos mientras se ejecuta codigo real internamente

## Estructura de Archivos del Desafio

| Archivo | Descripcion |
|---------|------------|
| `lib/data/model/post.dart` | Modelo de Post |
| `lib/data/model/comment.dart` | Modelo de Comment |
| `lib/data/sources/post_api_service.dart` | Servicio API para posts (Flutter) |
| `lib/data/sources/comment_native_service.dart` | Servicio nativo para comentarios (Platform Channel) |
| `lib/data/sources/like_local_service.dart` | Servicio local para likes (SharedPreferences) |
| `lib/data/repositories/post_repository.dart` | Repositorio de posts |
| `lib/data/repositories/comment_repository.dart` | Repositorio de comentarios |
| `lib/data/repositories/like_repository.dart` | Repositorio de likes |
| `lib/presentation/cubits/post_cubit/` | Estado y logica de posts |
| `lib/presentation/cubits/comment_cubit/` | Estado y logica de comentarios |
| `lib/presentation/cubits/like_cubit/` | Estado y logica de likes |
| `lib/presentation/screens/post_list_screen.dart` | Pantalla de listado con buscador |
| `lib/presentation/screens/post_detail_screen.dart` | Pantalla de detalle con comentarios |
| `lib/presentation/widgets/post_card_widget.dart` | Widget de tarjeta de post |
| `lib/presentation/widgets/comment_tile_widget.dart` | Widget de comentario |
| `ios/Runner/AppDelegate.swift` | Fetch nativo de comentarios (iOS) |
| `android/.../MainActivity.kt` | Fetch nativo de comentarios (Android) |
| `test/data/sources/like_local_service_test.dart` | Tests unitarios de LikeLocalService con SharedPreferences real |
| `test/data/repositories/like_repository_test.dart` | Tests unitarios de LikeRepository toggle logic |
| `test/presentation/cubits/like_cubit_test.dart` | Tests de LikeCubit con bloc_test para transiciones de estado |

## Requisitos del Sistema

- Flutter SDK 3.0.0 o superior
- Dart SDK 3.0.0 o superior
- Xcode (para compilar en iOS)
- Android Studio (para compilar en Android)
