class AddStatusToNails < ActiveRecord::Migration[6.1]
  def change
    add_column :nails, :status, :integer, default: 0, null: false
  end
end
