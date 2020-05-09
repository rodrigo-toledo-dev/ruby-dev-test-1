class RebuildNestedFileSystem < ActiveRecord::Migration[5.2]
  def up
    add_column :file_systems, :parent_id, :integer # Comment this line if your project already has this column
    add_column :file_systems, :lft,       :integer
    add_column :file_systems, :rgt,       :integer

    # optional fields
    add_column :file_systems, :depth,          :integer
    add_column :file_systems, :children_count, :integer

    # This is necessary to update :lft and :rgt columns
    FileSystem.reset_column_information
    FileSystem.rebuild!
  end

  def down
    remove_column :file_systems, :parent_id
    remove_column :file_systems, :lft
    remove_column :file_systems, :rgt

    # optional fields
    remove_column :file_systems, :depth
    remove_column :file_systems, :children_count
  end
end
