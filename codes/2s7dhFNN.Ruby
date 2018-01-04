class UpdatePlansModelAndDataAndLinkUser < ActiveRecord::Migration[5.0]
  def change
    # Remove old table
    drop_table :plans

    # Remove incorrect constrains
    remove_column   :users, :plan_id
    remove_column   :users, :expires_on
    remove_column   :users, :is_demo

    # Remove incorrect constrains
    remove_column :subscriptions, :plan_id

    create_table :plans do |t|
      t.integer :position
      t.integer :max_cards
      t.string  :plan_id
      t.timestamps
    end

    add_column :subscriptions, :expires_on, :date

    # Redo correct constrains
    add_reference :subscriptions, :plan, foreign_key: true
    add_reference :users, :subscription, foreign_key: true

    Plan.create(position: 1,  plan_id: 'free',     max_cards: 1)
    Plan.create(position: 2,  plan_id: 'basic',    max_cards: 1)
    Plan.create(position: 3,  plan_id: 'plus',     max_cards: 1)
    Plan.create(position: 4,  plan_id: 'premium',  max_cards: 3)
  end
end