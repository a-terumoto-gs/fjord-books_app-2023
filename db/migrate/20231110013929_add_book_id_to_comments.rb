class AddBookIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :book_id, :integer
  end
end
