class CreateApiResponses < ActiveRecord::Migration
  def change
    create_table :api_responses do |t|
      t.string :url, null: false
      t.text   :response, null:false

      t.timestamps null: false
    end
  end
end
