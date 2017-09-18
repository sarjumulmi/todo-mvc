class ListsController < ApplicationController
  before_action :authentication_required

  def index
    @lists = List.all
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @items = @list.items
    @item = @list.items.build
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      @lists = List.all
      render 'index'
    end

  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
