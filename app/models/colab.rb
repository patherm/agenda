class Colab < ApplicationRecord
  belongs_to :list
  validates :nome, allow_nil: true, presence:true

  validates_format_of :nome, allow_blank: true, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/
  validates_uniqueness_of :nome, allow_nil: true, message: " já existente no sistema"
  validates_length_of :nome, maximum:50
  before_validation :strip_whitespace, :only => [:nome]
  
  searchkick word_start: [:nome]

  after_commit :reindex_list

  	def reindex_list
    	Colab.reindex
  	end

    def strip_whitespace
      unless self.nome.nil?
        self.nome = self.nome.titleize
      end
    end

end
