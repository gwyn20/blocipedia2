class AddIndexToCollaborators < ActiveRecord::Migration[5.1]
  def change
    add_column :collaborators, :wiki_id, :integer
  end
end
