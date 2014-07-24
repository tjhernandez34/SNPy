class CreateMarkers < ActiveRecord::Migration
  def change
    create_table :markers do |t|
      t.string :snp
      t.string :allele
      t.integer :risk_level
      t.integer :disease_id

      t.timestamps
    end
  end
end
