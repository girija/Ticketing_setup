class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
		t.string :email
		t.string :ticket_no
		t.integer :user_id
		t.string :status, default: "new"
		t.string :subject
		t.text :message
		t.datetime :reply_date
		t.integer :agent_id
		t.text :answer
    	t.timestamps null: false
    end
  end
end
