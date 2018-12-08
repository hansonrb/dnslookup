class CreateDomains < ActiveRecord::Migration[5.2]
  def change
    create_table :domains do |t|
      t.string :name
      t.boolean :is_office365
      t.text :raw_dns
      t.timestamps
    end
  end
end
