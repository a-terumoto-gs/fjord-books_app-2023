class AddReportIdToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :report_id, :integer
  end
end
