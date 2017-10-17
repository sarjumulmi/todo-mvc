class ItemsController < ApplicationController

  def create
    # raise params.inspect
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)
    if @item.save
      respond_to do |format|
        format.html {redirect_to list_path(@list)}
        format.json {render :json =>@item}
      end
      # redirect_to list_path(@list)
    else
      @items = @list.items
      render 'lists/show'
    end
  end

  def update
    # raise params.inspect
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to list_path(@item.list)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to do |format|
      format.html {redirect_to list_path(@item.list)}
      format.json {render :json => @item}
    end
  end

  private
  def item_params
    params.require(:item).permit(:description, :status)
  end

end
