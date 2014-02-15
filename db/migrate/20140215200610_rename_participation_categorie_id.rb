class RenameParticipationCategorieId < ActiveRecord::Migration

  def up
    remove_column  :participations, :categorie_id
    #remove_index   :participations, :categorie_id
    add_column     :participations, :category_id, :integer 
    add_index      :participations, :category_id
  end

  def down
    remove_column :participations, :category_id
    #remove_index  :participations, :category_id
  end

end
