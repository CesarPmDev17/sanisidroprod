# app_san_isidro

En esta guía se dejan los comandos útiles para los procesos: run, debug y build.
<br/><br/>

# EJECUTAR APLICACIÓN EN MODO DEPURACIÓN
## Con las variables de entorno de Desarrollo
```
flutter run -t lib/main_dev.dart 
```

## Con las variables de entorno de Producción
```
flutter run -t lib/main_production.dart
```



# COMPILAR APLICACIÓN PARA TIENDA
## Crear el appbundle para subir a la tienda
```
flutter build appbundle -t lib/main_production.dart --release
```

<br/><br/>


# Configuraciones para VSCode
Para automatizar la ejecución en modo depuración, se puede crear una carpeta ***.vscode/*** (considerar el punto antes del texto) en el root del proyecto y agregar un archivo launch.json con el siguiente contenido:
```
{
  // Use IntelliSense para saber los atributos posibles.
  // Mantenga el puntero para ver las descripciones de los existentes atributos.
  // Para más información, visite: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Development",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_dev.dart"
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "program": "lib/main_production.dart"
    }
  ]
}
```