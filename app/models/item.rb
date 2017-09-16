class Item < ActiveRecord::Base
  belongs_to :list

  validates_presence_of :description, :message=>"Item description can't be blank!!"
end
