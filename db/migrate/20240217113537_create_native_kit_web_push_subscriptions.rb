class CreateNativeKitWebPushSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :native_kit_web_push_subscriptions do |t|
      t.references :subscriber, polymorphic: true, null: false
      t.string :endpoint, null: false
      t.string :auth_key, null: false
      t.string :p256dh_key, null: false

      t.datetime :created_at, null: false
    end
  end
end
