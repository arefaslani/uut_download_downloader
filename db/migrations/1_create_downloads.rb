require 'sequel'

Sequel.migration do
  up do
    create_table(:downloads) do
      primary_key :id
      String :progress
    end
  end

  down do
    drop_table(:downloads)
  end
end