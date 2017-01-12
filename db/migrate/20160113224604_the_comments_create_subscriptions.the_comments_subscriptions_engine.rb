# This migration comes from the_comments_subscriptions_engine (originally 20130101010105)
class TheCommentsCreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :comment_subscriptions do |t|
      t.integer :user_id
      t.integer :comment_id

      t.string :email, default: ''
      t.string :state, default: :active
    end
  end
end
