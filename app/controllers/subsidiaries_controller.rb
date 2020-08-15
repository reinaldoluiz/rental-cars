class SubsidiariesController < ApplicationController
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
        subsidiary_params = params.require(:subsidiary).permit(:name, :cnpj, :address)
        @subsidiary = Subsidiary.create(subsidiary_params)
        redirect_to subsidiary_path(@subsidiary)
    end
end