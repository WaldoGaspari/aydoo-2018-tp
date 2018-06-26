class MailServerUnreachableException < Exception

	def initialize
		super  "No se puede contactar al mail server"
	end
end
