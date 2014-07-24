class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.integer :genome_id
      t.integer :marker_id

      t.timestamps
    end
  end
end
