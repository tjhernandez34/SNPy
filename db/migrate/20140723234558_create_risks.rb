class CreateRisks < ActiveRecord::Migration
  def change
    create_table :risks do |t|
      t.integer :report_id
      t.integer :marker_id

      t.timestamps
    end
  end
end
