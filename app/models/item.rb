class Item < ActiveRecord::Base
  belongs_to :list

  validates_presence_of :description, :message=>"Item description can't be blank!!"

  def complete?
    self.status == 1
  end

  def incomplete?
    self.status == 0
  end
end
