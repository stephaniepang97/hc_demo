json.extract! account, :id, :name, :accountnumber, :billingcity, :sfid, :isdeleted, :created_at, :updated_at
json.url account_url(account, format: :json)
