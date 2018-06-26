require_relative '../model/json_entrada_exception'

class ContactosJsonDeEntradaException < JsonEntradaException

	def initialize
		@mensaje = "No posee una lista de contactos."
		raise @mensaje
	end
end

