<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

### Dependencia desde otro proyecto (Git)

En el `pubspec.yaml` del proyecto que usa este paquete:

```yaml
dependencies:
  iatros_uikit:
    git:
      url: https://github.com/TU_USUARIO/iatros_uikit.git  # o la URL de tu repo
      ref: main   # usa la rama principal (o un tag) para tener todos los widgets
```

**Importante:** usa siempre `ref: main` (o la rama/tag actual), no un commit antiguo.

### Si ves errores "Not found: package:iatros_uikit/..."

Eso indica que pub está usando una versión antigua en caché. En el **otro proyecto** ejecuta:

```bash
flutter pub cache repair
flutter pub get
```

Y en su `pubspec.yaml` asegúrate de que la dependencia apunte a la rama actual (`ref: main`) y no a un commit viejo.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
