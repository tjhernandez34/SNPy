  class CreateGenomes < ActiveRecord::Migration
  def change
    create_table :genomes do |t|
      t.integer :user_id
      t.string :file_url
      t.string :first_name
      t.string :last_name
      t.string :username

      t.timestamps
    end
  end
end
