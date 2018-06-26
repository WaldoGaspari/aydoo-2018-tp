class JsonEntradaException < Exception
attr_accessor :mensaje

	def initialize
		@mensaje = "No posee una lista de contactos."
		raise @mensaje
	end
end
