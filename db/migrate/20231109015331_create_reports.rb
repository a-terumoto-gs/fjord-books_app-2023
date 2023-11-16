class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: tru

      t.timestamps
    end
  end
end
