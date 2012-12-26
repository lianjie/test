class CreateCentres < ActiveRecord::Migration
  def change
    create_table :centres do |t|
      t.float :a
      t.float :b

      t.timestamps
    end
  end
end
