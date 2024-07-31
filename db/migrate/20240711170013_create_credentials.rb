class CreateCredentials < ActiveRecord::Migration[7.0]
  def change
    create_table :credentials do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
