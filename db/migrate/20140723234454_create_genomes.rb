class CreateGenomes < ActiveRecord::Migration
  def change
    create_table :genomes do |t|
      t.integer :user_id
      t.string :file_url

      t.timestamps
    end
  end
end
