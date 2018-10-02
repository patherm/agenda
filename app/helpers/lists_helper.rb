module ListsHelper

	def format_phone(telefone)
		number_to_phone(telefone, pattern: /(\d{2})(\d{4})(\d{4})$/, area_code: true)
	end
end
