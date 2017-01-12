# This migration comes from has_meta_data_engine (originally 1100)
class MetaDataCreate < ActiveRecord::Migration
  def change
    create_table :meta_data, force: :cascade do |t|
      t.references :holder, polymorphic: true

      t.text :title
      t.text :keywords
      t.text :description
      t.text :author

      t.text   :og_url
      t.string :og_type
      t.text   :og_image
      t.text   :og_site_name

      t.text   :og_title
      t.text   :og_description

      t.timestamps null: false
    end
  end
end