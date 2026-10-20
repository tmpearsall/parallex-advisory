class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :summary
      t.text :body, null: false
      t.datetime :published_at # nil = draft, never shown

      t.timestamps
    end
    add_index :posts, :slug, unique: true
    reversible do |dir|
      # Supabase exposes public tables over its API; Rails connects as the owner and is unaffected.
      dir.up { execute "ALTER TABLE posts ENABLE ROW LEVEL SECURITY" }
    end
  end
end
