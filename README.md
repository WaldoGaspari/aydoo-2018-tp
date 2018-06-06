Repositorio para el TP MailMerger

Alumnos: 

- Biscardi Maximiliano
- Gaspari Waldo



[![Build Status](https://travis-ci.org/WaldoGaspari/aydoo-2018-tp.svg?branch=master)](https://travis-ci.org/WaldoGaspari/aydoo-2018-tp)


Aclaraciones acerca del TP:

- Cumple con todas las funcionalidades solicitadas con sus respectivos tests.
- Los campos a reemplazar son revisados recorriendo los Strings.
- No se tuvieron en cuenta casos fuera de los limites. Tampoco hay excepciones y no se valida el esquema (json de entrada).
- La aplicacion utiliza Sinatra y esta configurado para funcionar con Mailcatcher para corroborar el envio de los mails. Se utilizó el puerto 1025 para el envio de los mails. Se chequea a traves de localhost:1080.
- Debido a lo anterior y a que necesita estar corriendo el mailcathcer para ver dichos mails se utilizó una clase fake para utilizarla en los test correspondientes. Esto hizo que localmente todos los tests implementados arrojen respuesta satisfactoria mientras que el Travis no. 
- Se entrega diagrama de clases y diagrama de secuencia.
