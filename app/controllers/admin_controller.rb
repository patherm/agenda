class AdminController < ApplicationController
before_action :authenticate_user!

  def index
    @list = List.where(params[:id])
      if params[:keywords].present?
        @lists = List.search params[:keywords], fields: [:setor, :nome, :telefone, :ramal], misspellings: false
        #@colabs = Colab.search params[:keywords], fields: [:nome], misspellings: false
        #Searchkick.multi_search([@lists, @colabs])
        else
          @lists = List.order(:setor)
          #@lists = List.all
        end
  end
end