class CreateUserAnalyzedSites < ActiveRecord::Migration[5.2]
  def change
    create_table :user_analyzed_sites do |t|
      t.integer :user_id
      t.integer :analyzed_site_id

      t.timestamps
    end
  end
end
