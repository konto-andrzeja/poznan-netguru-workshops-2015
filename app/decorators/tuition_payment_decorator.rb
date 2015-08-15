class TuitionPaymentDecorator < BaseDecorator
  def sortable_full_name
    "#{student.last_name}, #{student.first_name}"
  end

  def sortable_year_and_month
    month.strftime('%Y-%m (%B)')
  end

  def sortable_date
    date.strftime('%Y-%m-%d %H:%M')
  end

  def amount_paid
    '%.2f' % (amount.to_f / 100) + '$'
  end
end
