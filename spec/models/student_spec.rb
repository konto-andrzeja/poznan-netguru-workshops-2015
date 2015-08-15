require 'rails_helper'

RSpec.describe Student do
  describe 'validations' do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_inclusion_of(:birthdate).in_range(Date.today - 150.years..Date.yesterday).allow_nil.with_message('is not in the past or you are too old') }
  end

  describe 'database columns' do
    it { should have_db_column :first_name }
    it { should have_db_column :last_name }
    it { should have_db_column :birthdate }
  end

  describe 'associations' do
    it { is_expected.to have_many :subject_items }
    it { is_expected.to have_many :subject_item_notes }
    it { is_expected.to have_many :participations }
    it { is_expected.to have_many :tuition_payments }
  end

  describe 'nested attributes' do
    it { should accept_nested_attributes_for :subject_items }
  end
end
