class AddFamilyGoalToLeads < ActiveRecord::Migration[8.1]
  def change
    add_column :leads, :family_goal, :text
  end
end
