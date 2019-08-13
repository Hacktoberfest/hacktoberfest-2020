class ChangeTableUsers < ActiveRecord::Migration[5.2]
 def change
   change_table :users do |t|
     t.string :provider, default: 'github'
     t.rename :gh_id, :uid
     t.rename :gh_token, :provider_token
   end
 end
end
