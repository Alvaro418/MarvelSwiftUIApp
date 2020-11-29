# MarvelSwiftUIApp

##### Primeros pasos

Lo primero que es necesario saber es que, para que esta aplicación funcione es necesario rellenar los campos "API_KEY", "TIMESTAMP" y "PRIVATE_KEY". Estos campos pueden ser encontrados en los PLIST de configuración en los diferentes Targets que se pueden encontrar en las siguientes rutas:

./marvelapp/config/pro.plist
./marvelapp/config/test.plist

##### Tecnologías

Para esta aplicación he decidido utilizar el Framework de Desarrollo de SwiftUI ya que permite un desarrollo muy ágil con un código muy legible.

Para la parte de conexión con los servicios he decidido utilizar el Framework Combine, que permite explotar tanto la programación declarativa de SwiftUI como la programación funcional.

Este proyecto utiliza un modelo MVVM que creo que combina muy bien con el Framework SwiftUI y con la librería de Combine.

Para la generación de los modelos del esquema MVVM se ha utilizado el recurso https://quicktype.io/.

##### Test

En el código encontraréis la clase Authentication que permite gestionar la capa de autenticación del Api de Marvel. También encontraréis un fichero URLBase que controla la generación de las URLs.

Ambas clases vienen acompañadas de unos Test Unitarios muy sencillos.

También están disponibles los PreviewProvider de las diferentes vistas para el testeo visual sin necesidad de lanzar la aplicación.
