require 'rails_helper'

RSpec.describe TuitionPayment do
  describe 'database columns' do
    it { should have_db_column :date }
    it { should have_db_column :month }
    it { should have_db_column :amount }
    it { should have_db_column :student_id }
  end

  describe 'associations' do
    it { is_expected.to belong_to :student }
  end
end
