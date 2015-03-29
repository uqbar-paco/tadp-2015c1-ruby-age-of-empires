# tadp-2015c1-ruby-age-of-empires
Ejercicio de Age of Empires c1 2015

##Instalacion del entorno

Antes de instalar el entorno IDE para ruby, necesitaremos instalar el runtime de Ruby, 

apt (Debian o Ubuntu)
Debian GNU/Linux y Ubuntu se insta de la siguiente manera usando el apt:

```
$ sudo apt-get install ruby
```

yum (CentOS, Fedora, or RHEL)
CentOS, Fedora, y RHEL se instala de la siguiente manera:

```
$ sudo yum install ruby
```

portage (Gentoo)
Gentoo usa el gestor de paquetes portage.

```
$ sudo emerge dev-lang/ruby
```

pacman (Arch Linux)
En Arch Linux para instalar Ruby hay que hacer esto:

```
$ sudo pacman -S ruby
```

Homebrew (OS X)
En OS X basta con instalar Ruby de la siguiente manera:

```
$ brew install ruby
```

Windows

En windows la manera más sencilla de instalar el runtime es mediante [Ruby Installer](http://rubyinstaller.org/)

## Instalación del IDE

En caso de que opten por usar el Rubymine, pueden instalar el entorno en este [lugar](https://www.jetbrains.com/ruby/). Seguir las instrucciones que se dan en la página.

## Instalacion de las dependencias

En el caso que utilicen Rubymine, se bajarán las dependencias de rspec basándose en el Gemfile. Sino la manera de instalarlo manualmente es mediante gem.

```
$ gem install rspec
```

## Clonar el proyecto

```
$ git clone https://github.com/uqbar-paco/tadp-2015c1-ruby-age-of-empires
```

