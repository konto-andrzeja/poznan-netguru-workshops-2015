require 'spec_helper'

feature 'User visits tuition payments page' do
  let!(:student_1) { create :student, first_name: 'Adam', last_name: "Arnold" }
  let!(:student_2) { create :student, first_name: 'Barry', last_name: "Bouzan" }
  let!(:tuition_payment_1) { create :tuition_payment, student: student_1, amount: 25050, date: DateTime.new(2014, 10, 11, 12, 13), month: Date.new(2014, 10, 1) }
  let!(:tuition_payment_2) { create :tuition_payment, student: student_2, amount: 23050, date: DateTime.new(2012, 10, 11, 12, 13), month: Date.new(2012, 10, 1) }

  background do
    sign_in
    expect(page).to have_content 'Logout'
    visit report_tuition_payments_path
  end

  scenario 'should see tuition payments list with elements in the right order' do
    within('.breadcrumbs') do
      expect(page).to have_content 'RoR Workhops » Tuition payments'
    end

    expect(page.body.index(student_1.last_name)).to be < page.body.index(student_2.last_name)
  end

  scenario 'should be able to sort and search', :js => true do #without using js driver (I chose Selenium - Firefox must be installed) DataTables won't be loaded
    find("th", text: "Full name").click
    expect(page.body.index(student_1.last_name)).to be > page.body.index(student_2.last_name)
    fill_in "Search:", with: 'Arnold'
    expect(page).to have_content 'Arnold, Adam'
    expect(page).not_to have_content 'Bouzan'
  end

  scenario 'only when sign in' do
    logout
    visit report_tuition_payments_path
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
