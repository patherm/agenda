class ListsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :autocomplete]

	def index
    @list = List.where(params[:id])
    #@colab = Colab.where(params[:id])
      if params[:keywords].present?
        @lists = List.search params[:keywords], fields: [:setor, :nome, :telefone, :ramal], misspellings: false
        #@colabs = Colab.search params[:keywords], fields: [:nome], misspellings: false
        #Searchkick.multi_search([@lists, @colabs])
        else
          @lists = List.order(:setor)
          #@lists = List.all
      end
end

  	def autocomplete
	     setor = List.search(params[:keywords], {
	     fields: [:setor], match: :word_start, limit: 5, load: false, misspellings: false
	    }).map(&:setor ).uniq

	     nome = List.search(params[:keywords], {
	     fields: [:nome], match: :word_start, limit: 5, load: false, misspellings: false
	    }).map(&:nome ).uniq

	     telefone = List.search(params[:keywords], {
	     fields: [:telefone], match: :word_start, limit: 5, load: false, misspellings: false
	    }).map(&:telefone ).uniq

	     ramal = List.search(params[:keywords], {
	     fields: [:ramal], match: :word_start, limit: 5, load: false, misspellings: false
	    }).map(&:ramal ).uniq

	     render json: (nome + setor + telefone + ramal)
  	end

	def show
		@list = List.find(params[:id])
		render :edit
	end

	def edit
		if List.exists?(id: current_user.id)
			@list = List.find(params[:id])
		else
			new
		end
	end

	def update
		@list = List.find(params[:id])
		@user = User.find(params[:id])
		
		if @user.sign_in_count == 2
				@user.update!(sign_in_count: 3)
		end
		
		if @list.update(list_params)
			redirect_to admin_path, notice:"Registro modificado com sucesso!"
		else
			render :edit
		end

	end

	def new
		@list = List.new
    	@list.telefones.build
    	@list.colabs.build
	end

	def create
		@list = List.new(list_params)
		respond_to do |format|
			if @list.save
				if signed_in? && current_user.admin?
					@colab = Colab.last
					if @colab.nome.start_with?("Adm " || "adm ")
						@colab.nome = @colab.nome[4..-1]
						@colab.update!(nome: @colab.nome)
    					resolve_new(@colab.nome.to_s)
    				else
    					resolve_new(@colab.nome.to_s)
    				end
    			end
				format.html { redirect_to admin_path, notice: 'Registro criado com sucesso!' }
				format.js
	        	format.json { render :show, status: :created, location: @list }
			else
				format.html { render :new }
	        	format.json { render json: @list.errors, status: :unprocessable_entity }
			end
		end
	end

	def clear
		@list = List.find(params[:list_id])
		@telefone = Telefone.find(params[:list_id])
		@list.update!(setor: nil)
		@telefone.update!(telefone: nil, ramal: nil)
		redirect_to admin_path, alert:"Registro removido com sucesso!"
	end

	def destroy
		@list = List.find(params[:id])
		@telefone = Telefone.find(params[:id])
		@colab = Colab.find(params[:id])
		@user = User.find(params[:id])
		@list.destroy
		@telefone.destroy
		@colab.destroy
		@user.destroy
		redirect_to admin_path, alert:"Registro removido com sucesso!"
	end

	private

	def list_params
		params.require(:list).permit(:setor, telefones_attributes:[:id, :list_id, :telefone, :ramal, :_destroy], colabs_attributes:[:id, :list_id, :nome, :_destroy])
	end
end