class List < ApplicationRecord
	has_many :telefones
	has_many :colabs
	# belongs_to :user
  	accepts_nested_attributes_for :telefones, allow_destroy: true
  	accepts_nested_attributes_for :colabs, allow_destroy: true
	validates :setor, allow_nil: true, presence:true
	validates_length_of :setor, maximum:60
	#validates_uniqueness_of :nome, scope: [:setor], message: " já existente no sistema"
	#SETOR = ["Ambulatório", "Acolhimento/Triagem", "Assessoria de Comunicação (ASCOM)/Imprensa"]
	#AMB = ["8721016511"]
	#validates_inclusion_of :setor, in: SETOR
	#validates_inclusion_of :setor, in: SETOR['SETOR']
	validates_associated :telefones, allow_blank: true
	validates_associated :colabs, allow_blank: true
	
	searchkick word_start: [:setor, :nome, :telefone, :ramal]

	def search_data
		data = {
			setor: setor,
			nome: colabs.map(&:nome).join(' '),
			telefone: telefones.map(&:telefone).join(' '),
			ramal: telefones.map(&:ramal).join(' '),
		}
	end

	after_commit :reindex_list

  	def reindex_list
    	List.reindex
  	end

	 def self.created_at
	 	where('created_at <= ?' , Time.now).order('created_at desc')
	 end

end
