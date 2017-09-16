class ItemsController < ApplicationController

  def create
    # raise params.inspect
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to list_path(@list)
    else
      @items = @list.items
      render 'lists/show'
    end
  end

  private
  def item_params
    params.require(:item).permit(:description)
  end

end
