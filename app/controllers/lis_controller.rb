class LisController < ApplicationController
	
	def edit
		@li = Li.find(params[:id])
		#@li.tels.build
	end

	def update
		@li = Li.find(params[:id])
		if @li.update(li_params)
			redirect_to admin_path, notice:"Registro modificado com sucesso!"
		else
			render :edit
		end

	end

	def new
		@li = Li.new
    	@li.tels.build
	end

	def create
		@li = Li.new(li_params)
		if @li.save
			redirect_to admin_path, notice:"Registro criado com sucesso!"
		else
			render :new
		end
	end

	def destroy
		@li = Li.find(params[:id])
		@li.destroy
		redirect_to admin_path, alert:"Registro removido com sucesso!"
	end

	private

	def li_params
		params.require(:li).permit(:set, tels_attributes:[:id, :li_id, :tel, :ram, :_destroy])
	end
end