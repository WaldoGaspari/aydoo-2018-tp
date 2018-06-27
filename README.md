Repositorio para el TP MailMerger

Alumnos: 

- Biscardi Maximiliano
- Gaspari Waldo



[![Build Status](https://travis-ci.org/WaldoGaspari/aydoo-2018-tp.svg?branch=master)](https://travis-ci.org/WaldoGaspari/aydoo-2018-tp)


Aclaraciones acerca del TP:

- Cumple con todas las funcionalidades solicitadas con sus respectivos tests.
- Los campos a reemplazar son revisados recorriendo los Strings.
- Se generan excepciones validando el json de entrada lanzando un error de tipo 500.
- La aplicacion utiliza Sinatra y esta configurado para funcionar con Mailcatcher para el envio de los mails. Se utilizó el puerto 1025 para el envio de los mails. Se chequea a traves de localhost:1080.
- Se entrega diagrama de clases y diagrama de secuencia ubicados en la carpeta diagramas.
- En el caso de que algun json de entrada no contenga la etiqueta con su informacion correspondiente para ser reemplazado en el template se lanza un error de tipo 500. 
