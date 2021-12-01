# ASISTENCIA CLINICA

[![build](https://github.com/JuanVqz/doctors/actions/workflows/push.yml/badge.svg)](https://github.com/JuanVqz/doctors/actions/workflows/push.yml)
[![Ruby Style Guide](https://img.shields.io/badge/code_style-standard-brightgreen.svg)](https://github.com/testdouble/standard)

Es un sistema donde las instituciones clinicas podran registrar doctores para
tomar consultas de los pacientes y conservar el historial clinico.

## Requisitos

- ruby 2.7.2
- rails 6.0
- postgres

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

## Importar información (opcional)

Los Doctores que utilizan nuestro servicio habian usado un sistema llamado Bento.

Este sistema solo tenia soporte para Mac pero no lo han actualizado por lo tanto
los Doctores buscaron una alternativa web pero requieren el historial clinico de sus pacientes.

1. Exportar desde Bento

- El template de los pacientes
- El template de las consultas medicas

2. Crear un namespace con el nombre del doctor en la tarea import.rake

```
  namespace :import do
    namespace :doctor_name do
      task patients do
      end
      task medical_consultations do
      end
    end
  end
```

Ejecutar importación:

```ruby
rake import:doctor_name:patients
rake import:doctor_name:medical_consultation
```

## Deploy

### Reiniciar base de datos

```bash
heroku restart; heroku pg:reset DATABASE --confirm asistenciaclinica;
heroku run rails db:migrate
heroku run rails db:seed
heroku run rails console
```

## Deploy (deprecado)

Antes de realizar el deploy puedes verificar los requisitos con:

```sh
cap production deploy:check
```

Comandos para realizar deploy con capistrano:

```sh
cap production deploy
```

Despues de realizar el deploy, tienes que reiniciar unicorn con el comando siguiente:

```sh
cap production unicorn:start
```

## Desarrollo

Si esta interesado en contribuir al desarrollo comprando un subdominio en
[asistencia clinica](https://asistenciaclinica.com/) puede [contactarnos.](https://github.com/JuanVqz)
