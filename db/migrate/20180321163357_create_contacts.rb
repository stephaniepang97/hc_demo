class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :accountid
      t.string :sfid
      t.boolean :isdeleted

      t.timestamps
    end
  end
end
