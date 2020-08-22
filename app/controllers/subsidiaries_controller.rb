class SubsidiariesController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  
  def index
      @subsidiaries = Subsidiary.all
  end

  def show
      @subsidiary = Subsidiary.find(params[:id])
  end

  def new
      @subsidiary = Subsidiary.new
  end

  def create
      
      @subsidiary = Subsidiary.create(subsidiary_params)
      redirect_to subsidiary_path(@subsidiary)
  end

  def edit
      @subsidiary = Subsidiary.find(params[:id])
    end
    
  def update
    @subsidiary = Subsidiary.find(params[:id])
    if @subsidiary.update(subsidiary_params)
        redirect_to @subsidiary
    else
        render :edit
    end
  end
  def destroy
      @subsidiary = Subsidiary.find(params[:id])
      @subsidiary.destroy
      redirect_to subsidiaries_path
  end
  private
    def subsidiary_params
      params.require(:subsidiary).permit(:name, :cnpj, :address)
    end
end