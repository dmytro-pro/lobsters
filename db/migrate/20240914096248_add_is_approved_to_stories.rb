class AddIsApprovedToStories < ActiveRecord::Migration[7.1]
  def change
    add_column :stories, :is_approved, :boolean, default: false
  end
end
