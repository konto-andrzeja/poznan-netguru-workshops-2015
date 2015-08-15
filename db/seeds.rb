puts "Seeds: start"
TEACHER_TITLES = %w(Dr. Prof. TA)
User.create!(email: 'admin@admin.com',password: 'adminadmin')

3.times do
  Teacher.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    academic_title: TEACHER_TITLES.sample
  )
end

teachers = Teacher.all
5.times do
  SubjectItem.create!(
    title: Faker::Lorem.sentence,
    teacher: teachers.sample
  )
end

25.times do
  student = Student.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birthdate: Faker::Date.birthday(19, 35)
  )
  #for every student create random tuition payments
  years = (2005..2015).to_a.shuffle
  (1..rand(0..2)).each {
    year = years.pop
    months = (1..12).to_a.shuffle
    (1..rand(0..8)).each {
      first_day_of_month = Date.new(year, months.pop, 1)
      student.tuition_payments.create(
          month: first_day_of_month,
          date: Faker::Time.between(first_day_of_month, 1.month.since(first_day_of_month)),
          amount: Faker::Number.between(10000, 50000)
      )
    }
  }
end

students = Student.all
SubjectItem.all.each do |subject_item|
  subject_item.students << students.sample(rand(1..4))
end

SubjectItem.all.each do |subject_item|
  subject_item.students.each do |student|
    rand(1..5).times do
      subject_item.subject_item_notes << SubjectItemNote.create(student: student,
                                                                subject_item: subject_item,
                                                                value: rand(1..6))
    end
  end
end

puts "Seeds: done"
