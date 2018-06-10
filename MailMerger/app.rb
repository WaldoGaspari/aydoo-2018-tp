require 'sinatra'
require 'sinatra/json'
require 'json'
require 'net/smtp'
require_relative '../MailMerger/model/merger'
require_relative '../MailMerger/model/envio_de_mails'
require_relative '../MailMerger/model/json_de_entrada_exception'

configure do
  set :bind, '0.0.0.0'
end

post '/' do
  json_parseado = JSON.parse(request.body.read)
  merger = Merger.new
  enviador_mails = EnvioDeMails.new
  analizador_de_json = JsonDeEntradaException.new

  begin
    analizador_de_json.analizar_json_de_entrada(json_parseado)
  rescue
    halt 400, json({ error: "Datos incorrectos"})
  end

  merger.enviar_mails(json_parseado, enviador_mails)
  json({ "Resultado": "OK"})

end