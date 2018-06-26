class MailServerUnreachableException < Exception

	def initialize
		super  "No se puede contactar con el mail server"
	end
end
