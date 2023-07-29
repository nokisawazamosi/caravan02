class CreateBlogComments < ActiveRecord::Migration[6.1]
  def change
    create_table :blog_comments do |t|
      t.text :comment
      t.integer :user_id
      t.integer :blog_id

      t.timestamps
    end
  end
end
