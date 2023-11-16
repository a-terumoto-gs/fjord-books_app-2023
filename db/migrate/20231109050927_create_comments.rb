class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false
      t.integer :report_id
      t.integer :book_id

      t.timestamps
    end
  end
end
