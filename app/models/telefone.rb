class Telefone < ApplicationRecord
  belongs_to :list
  validates :telefone, allow_nil: true, presence:true
  validates :ramal, allow_blank: true, presence: true
  #validates_length_of :ramal, is:4
  #validates_length_of :telefone, is:10
  #validates_format_of :telefone, with: /\A(([1-9]{2})?([1-9]{1})?([0-9]{3})?(\-)?[0-9]{4})?\Z/

  searchkick text_end: [:telefone, :ramal]

  #after_commit :reindex_list

  	def reindex_list
    	Telefone.reindex
  	end


end
