class RemoveNamaFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :nama
  end
end
