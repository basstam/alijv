require 'test_helper'

feature 'FindMatchingCategory' do

  before(:each) do
    visit new_participant_path
  end

  scenario ' Show active activity in participant form' do
    page.must_have_content 'Nieuwe Deelnemer'
    page.must_have_content Activity.active.name
  end

  scenario 'find matching category when filling in your participant form', :js => true do
    fill_in 'participant_date_of_birth', :with => '01-02-1975'
    choose('participant_gender_m')
    select('8', :from => 'participant_distance')
    find('#result_category').must_have_content 'Mannen senioren 8k'
  end

  scenario 'tell if no matching category is found when filling in your participant form', :js => true do
    fill_in 'participant_date_of_birth', :with => '01-02-1975'
    choose('participant_gender_f') #Need to add this line to trigger the change event
    find('#result_category').must_have_content 'Nog geen bijbehorende categorie gevonden!'
  end

end
