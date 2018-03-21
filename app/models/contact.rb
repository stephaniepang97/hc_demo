class Contact < ApplicationRecord
	has_many :accounts, foreign_key: :accountid
	self.table_name = "salesforce.contact"
end
