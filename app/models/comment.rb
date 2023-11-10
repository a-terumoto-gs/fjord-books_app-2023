class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  
  attr_accessor :name
  before_save :set_name

  private

  def set_name
    self.name = user&.name || '退会済みユーザー'
  end
end
