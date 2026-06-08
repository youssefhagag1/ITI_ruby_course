class CreateArticles < ActiveRecord::Migration[8.0]
  def change
    create_table :articles do |t|
      t.string  :title,         null: false
      t.text    :body,          null: false
      t.references :user,       null: false, foreign_key: true
      t.integer :reports_count, null: false, default: 0
      t.string  :status,        null: false, default: "published"
                                # status: "published" | "archived"

      t.timestamps
    end
  end
end
