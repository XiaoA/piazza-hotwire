class CreateAppSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :app_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :token_digest

      t.timestamps
    end
  end
end
