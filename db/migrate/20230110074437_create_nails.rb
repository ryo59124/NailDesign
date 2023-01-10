class CreateNails < ActiveRecord::Migration[6.1]
  def change
    create_table :nails do |t|
      t.integer :end_user_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
