require 'rspec'
require_relative '../model/envio_de_mails'
require 'json'

describe 'enviar mails' do

  let(:envio) { EnvioDeMails.new }

  it 'se envia un mail' do
    expect(envio.enviar.to be_truthy)
  end

end