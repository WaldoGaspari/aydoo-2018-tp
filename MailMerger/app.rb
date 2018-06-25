require 'sinatra'
require 'sinatra/json'
require 'json'
require 'net/smtp'
require_relative '../MailMerger/model/merger'
require_relative '../MailMerger/model/envio_de_mails'
require_relative '../MailMerger/model/analizador_json_de_entrada'

configure do
  set :bind, '0.0.0.0'
end

post '/' do
  json_parseado = JSON.parse(request.body.read)
  merger = Merger.new
  enviador_mails = EnvioDeMails.new
  analizador_de_json = AnalizadorJsonDeEntrada.new

  begin
    analizador_de_json.analizar_json_de_entrada(json_parseado)
  rescue
    halt 500, json({ "resultado": "error, entrada incorrecta"})
  end

  begin
    merger.enviar_mails(json_parseado, enviador_mails)
    json({ "resultado": "ok"})
  rescue RuntimeError
    halt 500, json({ "resultado": "error, etiquetas incompletas"})
  rescue Errno::ECONNREFUSED
    halt 500, json({ "resultado": "error, no se puede conectar al servidor de mail"})
  end

end