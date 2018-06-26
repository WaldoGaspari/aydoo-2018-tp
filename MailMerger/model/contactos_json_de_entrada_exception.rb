class ContactosJsonDeEntradaException < StandardError

	def initialize
		raise "No posee una lista de contactos."
	end
end

