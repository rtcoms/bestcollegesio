class CreateApiResponses < ActiveRecord::Migration
  def change
    create_table :api_responses do |t|

      t.string  :url, null: false
      t.text    :response
      t.text    :error_message
      t.boolean :success

      t.timestamps null: false
    end
  end
end
