module ItemsHelper
  def class_for_item_li(item)
    "completed" if item.complete?
  end

  def item_description_placeholder(item)
    item.errors[:description][0] || 'Insert new items...'
  end

  def li_for_item(item)
    content_tag_for :li, item, :class => class_for_item_li(item) do
      yield
    end
  end

  def form_for_item_status(item)
    form_for([item.list, item]) do |f|
      f.check_box :status, :class=>"toggle", :checked=>item.complete?
    end
  end
end
