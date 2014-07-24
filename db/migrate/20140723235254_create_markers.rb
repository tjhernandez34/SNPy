class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :rsid
      t.string :snp
      t.integer :risk_level
      t.integer :disease_id

      t.timestamps
    end
  end
end
