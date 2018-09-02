class AddStatusToAnalyzedSites < ActiveRecord::Migration[5.2]
  def change
    add_column :analyzed_sites, :status, :string
  end
end
