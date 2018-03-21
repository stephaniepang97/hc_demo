json.extract! contact, :id, :firstname, :lastname, :email, :accountid, :sfid, :isdeleted, :created_at, :updated_at
json.url contact_url(contact, format: :json)
