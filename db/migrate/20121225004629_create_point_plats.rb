class CreatePointPlats < ActiveRecord::Migration
  def change
    create_table :point_plats do |t|
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
