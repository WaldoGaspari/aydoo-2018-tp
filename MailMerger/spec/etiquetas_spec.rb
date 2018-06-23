require 'rspec'
require_relative '../model/etiquetas'
require 'json'

class EtiquetasSpec
  describe 'etiqueta date' do

    it 'aplico etiqueta directa' do
      texto = " asf <date:d> aomimv "
      aplicador = EtiquetaFecha.new

      texto = aplicador.aplicar_fechas(texto)

      expect(texto).to eq " asf #{Date.today.strftime("%d-%m-%Y")} aomimv "
    end

    it 'aplico etiqueta inversa' do
      texto = " asf <date:i> aomimv "
      aplicador = EtiquetaFecha.new

      texto = aplicador.aplicar_fechas(texto)

      expect(texto).to eq " asf #{Date.today.strftime("%Y-%m-%d")} aomimv "
    end
  end

  describe 'etiqueta empty' do

    it 'aplico etiqueta y empty existe' do
      texto = " asf <empty(pais,argentina)> aomimv "
      js = {
          "template":"Hola <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollarÃ¡ en <lugar_del_evento>, el dÃ­a <fecha_del_evento>. Por favor confirmar su participaciÃ³n enviando un mail a <mail_de_confirmacion>.\n\rSin otro particular.La direccion",
          "contactos":[
              {
              "nombre":"juan",
          "apellido":"perez",
          "mail":"juanperez@test.com"
      },
          {
              "nombre":"maria",
              "apellido":"gonzalez",
              "mail":"mariagonzalez@test.com"
          }
      ],
          "datos":{
          "asunto":"InvitaciÃ³n a fiesta de fin de aÃ±o",
          "nombre_evento":"la cena de fin de aÃ±o de la UNTREF",
          "lugar_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
          "fecha_del_evento":"5 de diciembre",
          "Mail_de_confirmacion":"fiesta@untref.com",
          "pais":"uruguay"
      }
      }

      aplicador = EtiquetaEmpty.new

      texto = aplicador.aplicar_empty(texto, js)

      expect(texto).to eq " asf uruguay aomimv "
    end

    it 'aplico etiqueta y empty NO existe' do
      texto = " asf <empty(pais,argentina)> aomimv "
      js = {
          "template":"Hola <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollarÃ¡ en <lugar_del_evento>, el dÃ­a <fecha_del_evento>. Por favor confirmar su participaciÃ³n enviando un mail a <mail_de_confirmacion>.\n\rSin otro particular.La direccion",
          "contactos":[
              {
              "nombre":"juan",
          "apellido":"perez",
          "mail":"juanperez@test.com"
      },
          {
              "nombre":"maria",
              "apellido":"gonzalez",
              "mail":"mariagonzalez@test.com"
          }
      ],
          "datos":{
          "asunto":"InvitaciÃ³n a fiesta de fin de aÃ±o",
          "nombre_evento":"la cena de fin de aÃ±o de la UNTREF",
          "lugar_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
          "fecha_del_evento":"5 de diciembre",
          "Mail_de_confirmacion":"fiesta@untref.com",
      }
      }
      js.to_json

      aplicador = EtiquetaEmpty.new

      texto = aplicador.aplicar_empty(texto, js)

      expect(texto).to eq " asf argentina aomimv "
    end

  end

  describe 'etiqueta suma' do

    it 'aplico suma' do
      texto = " asf <sum(17,23)>:asdvgev aomimv "
      aplicador = EtiquetaSuma.new

      texto = aplicador.aplicar_suma(texto)

      expect(texto).to eq " asf 40:asdvgev aomimv "
    end

    it 'aplico suma y no hay suma' do
      texto = " asf <sm(17,23)>:asdvgev aomimv "
      aplicador = EtiquetaSuma.new

      texto = aplicador.aplicar_suma(texto)

      expect(texto).to eq " asf <sm(17,23)>:asdvgev aomimv "
    end

  end

  describe 'todas las etiquetas' do

    it 'aplico etiqueta y empty NO existe' do
      texto = " asf <date:d> aomimv asf <empty(pais,italia)> aomimv <date:i> suma <sum(19,11)> deberia ser 30 asf <time> aomimv "
      js = {
          "template":"Hola <nombre>,\n\r Por medio del presente mail te estamos invitando a <nombre_evento>, que se desarrollarÃ¡ en <lugar_del_evento>, el dÃ­a <fecha_del_evento>. Por favor confirmar su participaciÃ³n enviando un mail a <mail_de_confirmacion>.\n\rSin otro particular.La direccion",
          "contactos":[
              {
              "nombre":"juan",
              "apellido":"perez",
              "mail":"juanperez@test.com"
      },
          {
              "nombre":"maria",
              "apellido":"gonzalez",
              "mail":"mariagonzalez@test.com"
          }
      ],
          "datos":{
          "asunto":"InvitaciÃ³n a fiesta de fin de aÃ±o",
          "nombre_evento":"la cena de fin de aÃ±o de la UNTREF",
          "lugar_evento":"el Centro de estudios (avenida Directorio 887, Caseros)",
          "fecha_del_evento":"5 de diciembre",
          "Mail_de_confirmacion":"fiesta@untref.com",
      }
      }
      js.to_json

      aplicador = Etiquetas.new

      texto = aplicador.aplicar(texto, js)

      expect(texto).to eq " asf #{Date.today.strftime("%d-%m-%Y")} aomimv asf italia aomimv #{Date.today.strftime("%Y-%m-%d")} suma 30 deberia ser 30 asf #{Time.now.strftime("%H:%M")} aomimv "
    end
  end

  describe 'etiqueta time' do

    it 'aplico etiqueta en formato 24hs' do
      texto = " asf <time> aomimv "
      aplicador = EtiquetaTime.new

      texto = aplicador.aplicar_time(texto)

      expect(texto).to eq " asf #{Time.now.strftime("%H:%M")} aomimv "
    end

    it 'aplico etiqueta en formato 12hs' do
      texto = " asf <time:12> aomimv "
      aplicador = EtiquetaTime.new

      texto = aplicador.aplicar_time(texto)

      expect(texto).to eq " asf #{Time.now.strftime("%l:%M")} pm aomimv "
    end

  end
end