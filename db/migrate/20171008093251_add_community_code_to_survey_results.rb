class AddCommunityCodeToSurveyResults < ActiveRecord::Migration[5.1]
  def change
    add_column :survey_results, :community_code, :string
  end
end
