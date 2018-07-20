class CreateSubscribers < ActiveRecord::Migration[5.2]
  def change
    create_table :subscribers do |t|
      t.string :stripe_customer_id, null: false
      t.string :stripe_subscription_id, null: false
      t.datetime :subscribed_at, :subscription_expires_at
      t.integer :plan_id, null: false
      t.integer :status, default: 0
      t.timestamps
    end

    add_reference :subscribers, :company, foreign_key: true
    add_index :subscribers, :plan_id, name: "plans_for_subsribers"
    add_index :subscribers, :subscribed_at, name: "subscribed_at_for_subscribers"
    add_index :subscribers, :subscription_expires_at, name: "expiring_subscritions_on_subscribers"
  end
end
