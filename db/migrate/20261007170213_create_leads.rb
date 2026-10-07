class CreateLeads < ActiveRecord::Migration[8.1]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :email
      t.string :organization
      t.string :role_title
      t.string :investor_type
      t.text :message
      t.string :stage, null: false, default: "inquiry"
      t.string :source
      t.text :notes
      t.datetime :contacted_at

      t.timestamps
    end
    add_index :leads, :stage
  end
end
