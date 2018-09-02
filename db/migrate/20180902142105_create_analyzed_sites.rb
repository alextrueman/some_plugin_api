class CreateAnalyzedSites < ActiveRecord::Migration[5.2]
  def change
    create_table :analyzed_sites do |t|
      t.string :url
      t.string :hexdigest
      t.text :source

      t.timestamps
    end
  end
end
