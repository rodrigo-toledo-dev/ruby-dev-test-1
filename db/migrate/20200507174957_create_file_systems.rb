class CreateFileSystems < ActiveRecord::Migration[6.0]
  def change
    create_table :file_systems do |t|
      t.string :name
      t.boolean :is_file

      t.timestamps
    end
  end
end
