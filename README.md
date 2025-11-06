# Flutter Application - Prueba Técnica

Aplicación Flutter que consume una API externa y permite guardar elementos en una base de datos local (Hive), con navegación entre pantallas, búsqueda en tiempo real y gestión completa de preferencias.

## 📋 Descripción

Esta documentación esta en español pero el codigo esta en ingles como buena practica.

### Pantallas Principales

1. **Listado de Ítems de la API** (`/api-list`)

2. **Crear Nueva Preferencia** (`/prefs/new`)

3. **Lista de Preferencias Guardadas** (`/prefs`)

4. **Detalle de Preferencia** (`/prefs/:id`)

### Características Técnicas

- **Gestión de Estado**: Bloc/Cubit pattern con `flutter_bloc`
- **Navegación**: GoRouter para enrutamiento declarativo
- **Persistencia Local**: Hive para almacenamiento NoSQL
- **HTTP Client**: Dio para peticiones a la API
- **Arquitectura**: Clean Architecture (separación en capas: data, domain, presentation)
- **Manejo de Errores**: Estados específicos con mensajes amigables
- **Búsqueda en Tiempo Real**: Filtrado 

### Requisitos del Sistema

- **Flutter SDK**: 3.0.0 o superior
- **Dart SDK**: 3.0.0 o superior 

## Dependencias Principales

```yaml
dependencies:
  flutter_bloc: ^8.x.x          
  go_router: ^13.x.x            
  hive: ^2.x.x                  
  hive_flutter: ^1.x.x          
  dio: ^5.x.x                   
  equatable: ^2.x.x             

dev_dependencies:
  build_runner: ^2.x.x         
  hive_generator: ^2.x.x       
```

## Instalación

### 1. Clonar el repositorio

```bash
git clone <url-del-repositorio>
cd flutter_application_1
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Generar archivos de código (Hive adapters)

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

Este comando generará los archivos necesarios como `preference_model.g.dart`.


## Ejecución

### Ejecutar en modo desarrollo

```bash
flutter run
```

## Estructura del Proyecto

```
lib/
├── main.dart                          # Punto de entrada de la aplicación
├── core/                              # Funcionalidades core
│   ├── constants/                     # Constantes (URLs API, timeouts)
│   ├── errors/                        # Excepciones personalizadas
│   └── utils/                         # Utilidades generales
├── data/                              # Capa de datos
│   ├── model/                         # Modelos de datos
│   │   ├── item.dart                  # Modelo Item de la API
│   │   ├── preference_model.dart      # Modelo Preference (Hive)
│   │   └── preference_model.g.dart    # Generado por Hive
│   ├── repositories/                  # Implementación de repositorios
│   └── sources/                       # Fuentes de datos
│       ├── api_service.dart           # Servicio API (Dio)
│       └── hive_service.dart          # Servicio Hive (local DB)
├── domain/                            # Lógica de negocio (si aplica)
└── presentation/                      # Capa de presentación
    ├── cubits/                        # Gestión de estado
    │   ├── api_cubit/                 # Cubit para API
    │   │   ├── api_cubit.dart
    │   │   └── api_state.dart
    │   └── prefs_cubit/               # Cubit para Preferencias
    │       ├── prefs_cubit.dart
    │       └── prefs_state.dart
    ├── routes/                        # Configuración de rutas
    │   └── app_router.dart            # GoRouter configuration
    ├── screens/                       # Pantallas de la app
    │   ├── api_list_view.dart         # Lista de API con búsqueda
    │   ├── prefs_new_view.dart        # Crear preferencia
    │   ├── prefs_list_view.dart       # Lista de preferencias
    │   └── prefs_detail_view.dart     # Detalle de preferencia
    └── widgets/                       # Widgets reutilizables
```
