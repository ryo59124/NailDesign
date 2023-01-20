class CreateNailTags < ActiveRecord::Migration[6.1]
  def change
    create_table :nail_tags do |t|
      t.references :nail, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :nail_tags, [:nail_id, :tag_id], unique: true
  end
end
