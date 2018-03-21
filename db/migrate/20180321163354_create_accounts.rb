class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :accountnumber
      t.string :billingcity
      t.string :sfid
      t.boolean :isdeleted

      t.timestamps
    end
  end
end
