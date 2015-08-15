require 'rails_helper'

describe TuitionPaymentDecorator do
  let(:student) { create :student, first_name: 'John', last_name: 'Smith' }
  let(:tuition_payment) { create :tuition_payment, student: student, amount: 25050, date: DateTime.new(2014, 10, 11, 12, 13), month: Date.new(2014, 10, 1) }

  describe "#sortable_full_name" do
    subject { tuition_payment.decorate.sortable_full_name }
    it { is_expected.to eq 'Smith, John' }
  end

  describe "#sortable_year_and_month" do
    subject { tuition_payment.decorate.sortable_year_and_month }
    it { is_expected.to eq '2014-10 (October)' }
  end

  describe "#sortable_date" do
    subject { tuition_payment.decorate.sortable_date }
    it { is_expected.to eq '2014-10-11 12:13' }
  end

  describe "#amount_paid" do
    subject { tuition_payment.decorate.amount_paid }
    it { is_expected.to eq '250.50$' }
  end
end
