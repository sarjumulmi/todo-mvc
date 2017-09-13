class ListsController < ApplicationController

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
  end

  def create
    @list = List.create(list_params)
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
