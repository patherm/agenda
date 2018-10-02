class ColabsController < ApplicationController
  #before_action :set_colab, only: [:show, :edit, :update, :destroy]
  before_action :set_list

  # GET /colabs
  # GET /colabs.json
  def index
    @colabs = @list.colabs
  end

  # GET /colabs/1
  # GET /colabs/1.json
  def show
  end

  # GET /colabs/new
  def new
    @colab = Colab.new
  end

  # GET /colabs/1/edit
  def edit
  end

  # POST /colabs
  # POST /colabs.json
  def create
    @colab = @colab.new(colab_params)
    respond_to do |format|
      if @colab.save
        format.html { redirect_to @colab, notice: 'Colab was successfully created.' }
        format.json { render :show, status: :created, location: @colab }
      else
        format.html { render :new }
        format.json { render json: @colab.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colabs/1
  # PATCH/PUT /colabs/1.json
  def update
    respond_to do |format|
      if @colab.update(colab_params)
        format.html { redirect_to @colab, notice: 'Colab was successfully updated.' }
        format.json { render :show, status: :ok, location: @colab }
      else
        format.html { render :edit }
        format.json { render json: @colab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colabs/1
  # DELETE /colabs/1.json
  def destroy
    @colab.destroy
    respond_to do |format|
      format.html { redirect_to colabs_url, notice: 'Colab was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colab
      @colab = Colab.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])     
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def colab_params
      params.require(:colab).permit(:nome, :list_id)
    end
end
