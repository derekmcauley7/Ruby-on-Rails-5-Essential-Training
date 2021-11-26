class AddPageIndexs < ActiveRecord::Migration[6.1]

  def up
    add_index("pages", "subject_id")
    add_index("pages", "permalink")
    add_index("sections", "page_id")
  end

  def down

  end

end
