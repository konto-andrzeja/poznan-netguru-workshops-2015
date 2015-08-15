class StudentDecorator < BaseDecorator
  def full_name
    "#{first_name} #{last_name}"
  end

  def avg_notes(subject_item)
    notes = subject_item_notes.for_subject_item(subject_item)
    "%.2f" % (notes.empty? ? 0 : notes.to_a.sum(&:value).to_f / notes.length)
  end
end
