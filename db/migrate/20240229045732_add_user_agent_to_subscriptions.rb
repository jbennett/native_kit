class AddUserAgentToSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :native_kit_web_push_subscriptions, :user_agent, :string
  end
end
