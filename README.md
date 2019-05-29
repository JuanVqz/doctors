# ASISTENCIA CLINICA

Es un sistema donde las instituciones clinicas podran registrar doctores para
tomar consultas de los pacientes y conservar el historial clinico.

## Requisitos
  * ruby 2.5.3
  * rails 5.2.2
  * postgres

## Instalación
```sh
git clone https://JuanVqz@bitbucket.org/JuanVqz/doctors.git
cd doctors
bundle install
```

## Ejecutar servidor
Es necesario utilizar `lvh.me:300` para ingresar a los subdominio desde el ambiente
de desarrollo, si ejecuta las semillas existe un subdominio `stark-headland-73197`
y debes ingresar de la siguiente manera.

iniciar el servidor
```sh
rails server
```
visitar la ruta
```
http://stark-headland-73197.lvh.me:3000
```
e iniciar sesión con el doctor (administrador)
```
usuario: pedrouno@gmail.com
contraseña: 123456
```

## Desarrollo
Si esta interesado en contribuir al desarrollo comprando un subdominio en
[asistencia clinica](https://asistenciaclinica.com/) puede contactarnos.
