class CreateSection < ActiveRecord::Migration[6.1]
  def change
    create_table :sections do |t|
      t.integer "page_id"
      t.string "name", :limit => 100
      t.integer "position"
      t.boolean "visible", :default => true
      t.string "contect_type"
      t.text "context"
      t.timestamps
    end
  end
end
