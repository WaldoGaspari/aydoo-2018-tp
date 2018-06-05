require 'sinatra'
require 'sinatra/json'
require 'json'
require 'net/smtp'
require_relative '../MailMerger/model/merger'
require_relative '../MailMerger/model/envio_de_mails'

configure do
  set :bind, '0.0.0.0'
end

post '/' do
  json_parseado = JSON.parse(request.body.read)
  merger = Merger.new
  merger.enviarMails(json_parseado)
  json({ "Resultado": "OK"})
end