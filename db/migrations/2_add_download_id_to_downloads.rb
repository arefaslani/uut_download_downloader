require 'sequel'

Sequel.migration do
  up do
    add_column :downloads, :download_id, :string, unique: true, index: true
  end

  down do
    drop_column :downloads, :download_id
  end
end