class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :blog_title
      t.text :caption
      t.integer :user_id

      t.timestamps
    end
  end
end
