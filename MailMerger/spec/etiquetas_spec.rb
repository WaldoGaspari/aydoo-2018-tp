require 'rspec'
require_relative '../model/etiquetas'
require 'json'

class Etiquetas_spec
  describe 'etiqueta dia' do

    it 'aplico etiqueta directa' do
      texto = " asf <date:d> aomimv "
      aplicador = Etiquetas.new

      texto = aplicador.aplicarFecha(texto)

      expect(texto).to eq " asf #{Date.today.day}-#{Date.today.month}-#{Date.today.year} aomimv "
    end

    it 'aplico etiqueta inversa' do
      texto = " asf <date:i> aomimv "
      aplicador = Etiquetas.new

      texto = aplicador.aplicarFecha(texto)

      expect(texto).to eq " asf #{Date.today.year}-#{Date.today.month}-#{Date.today.day} aomimv "
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

      aplicador = Etiquetas.new

      texto = aplicador.aplicarEmpty(texto,js)

      expect(texto).to eq " asf <empty(pais,argentina)> aomimv "
    end

    it 'aplico etiqueta y empty NO existe' do
      texto = " asf <empty(pais,argentina)> aomimv "
      #js = JSON.generate
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

      texto = aplicador.aplicarEmpty(texto,js)

      expect(texto).to eq " asf argentina aomimv "
    end

  end
  describe 'etiqueta suma' do

    it 'aplico suma' do
      texto = " asf <sum(17,23)>:asdvgev aomimv "
      aplicador = Etiquetas.new

      texto = aplicador.aplicarSuma(texto)

      expect(texto).to eq " asf 40:asdvgev aomimv "
    end

    it 'aplico suma y no hay suma' do
      texto = " asf <sm(17,23)>:asdvgev aomimv "
      aplicador = Etiquetas.new

      texto = aplicador.aplicarSuma(texto)

      expect(texto).to eq " asf <sm(17,23)>:asdvgev aomimv "
    end

  end

  describe 'todas las etiquetas' do

    it 'aplico etiqueta y empty NO existe' do
      texto = " asf <date:d> aomimv asf <empty(pais,italia)> aomimv <date:i> suma <sum(19,11)> deberia ser 30"
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

      texto = aplicador.aplicar_todas(texto,js)

      expect(texto).to eq " asf #{Date.today.day}-#{Date.today.month}-#{Date.today.year} aomimv asf italia aomimv #{Date.today.year}-#{Date.today.month}-#{Date.today.day} suma 30 deberia ser 30"
    end


  end
end