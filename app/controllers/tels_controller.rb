class TelefonesController < ApplicationController
  
  # GET /telefones/new
  def new
    @tel = Tel.new
  end

  # GET /telefones/1/edit
  def edit
  end

  # POST /telefones
  # POST /telefones.json
  def create
    @tel = @tel.new(tel_params)
    respond_to do |format|
      if @tel.save
        format.html { redirect_to admin_path, notice: 'tel was successfully created.' }
        format.json { render :show, status: :created, location: @tel }
      else
        format.html { render :new }
        format.json { render json: @tel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tels/1
  # PATCH/PUT /tels/1.json
  def update
    respond_to do |format|
      if @tel.update(tel_params)
        format.html { redirect_to @tel, notice: 'tel was successfully updated.' }
        format.json { render :show, status: :ok, location: @tel }
      else
        format.html { render :edit }
        format.json { render json: @tel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tels/1
  # DELETE /tels/1.json
  def destroy
    @tel.destroy
    respond_to do |format|
      format.html { redirect_to tels_url, notice: 'tel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_li
      @li = Li.find(params[:li_id])     
    end

    # Never trust parameters from the scary internet, only allow the white li through.
    def tel_params
      params.require(:tel).permit(:tel, :ramal, :li_id)
    end
end
