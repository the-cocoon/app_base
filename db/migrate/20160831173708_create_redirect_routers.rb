class CreateRedirectRouters < ActiveRecord::Migration
  def change
    create_table :redirect_routers do |t|
      t.text     :from_url
      t.text     :to_url
      t.integer  :redirect_count, default: 0
      t.integer  :status_code, default: 301

      t.timestamps null: false
    end
  end
end
