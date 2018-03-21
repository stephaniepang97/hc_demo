class Account < ApplicationRecord
	belongs_to :contact, foreign_key: :accountid
	self.table_name = "salesforce.account"
end
