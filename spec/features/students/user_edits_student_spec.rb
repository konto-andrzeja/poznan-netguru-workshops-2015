require 'spec_helper'

feature 'User edits student' do
  let!(:student) { create :student, first_name: 'Jan', last_name: 'Abacki', birthdate: Date.new(2005, 10, 10) }
  let!(:subject_item) { create :subject_item, title: 'Math' }

  background do
    sign_in
    expect(page).to have_content 'Logout'
    visit students_path
    find(:xpath, "//a[@title='edit']").click
  end

  scenario 'and checks breadcrumbs presence' do
    within('.breadcrumbs') do
      expect(page).to have_content 'RoR Workhops » Students  » Jan Abacki'
    end
  end

  scenario 'with valid first name' do
    fill_in 'First name', with: 'Marcin'
    click_button 'Update Student'
    expect(page).to have_content 'Student has been updated!'
    expect(page).to have_content 'Marcin'
  end

  scenario 'with valid birthdate' do
    find('#student_birthdate').set('12/12/2005')
    click_button 'Update Student'
    expect(page).to have_content 'Student has been updated!'
    expect(page).to have_content '2005-12-12'
  end

  scenario 'with invalid first name' do
    fill_in 'First name', with: ''
    click_button 'Update Student'
    expect(page).to have_content "can't be blank"
  end

  scenario 'with invalid birthdate' do
    find('#student_birthdate').set('12/12/2850')
    click_button 'Update Student'
    expect(page).to have_content "is not in the past or you are too old"
  end

  scenario 'by assigning subject item' do
    visit report_subjects_path
    expect(page).to have_no_content 'Jan Abacki'

    visit students_path
    find(:xpath, "//a[@title='edit']").click
    find("input[type='checkbox']").set(true)
    click_button 'Update Student'

    visit report_subjects_path
    expect(page).to have_content 'Jan Abacki'
  end
end
