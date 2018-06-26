class JsonEntradaException < Exception
attr_accessor :mensaje

	def initialize
		@mensaje = "faltan datos en el json de entrada."
		raise @mensaje
	end
end
