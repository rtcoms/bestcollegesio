class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.string :user_id
      t.string :provider
      t.string :uid
      t.string :username
      t.string :image_url
      t.string :token
      t.string :secret
      t.json   :oauth_response
      t.timestamps
    end
  end
end
