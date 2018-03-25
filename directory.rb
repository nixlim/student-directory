def input_students()
  puts "Please enter details of the students"
  puts "To finish, just hit return twice"
  students = []
  puts "Please enter the name"
  name = gets.tr("\n\r","")
  puts "Please enter cohort"
  cohort = gets.tr("\n\r","")
  while !name.empty? do
    cohort = :november if cohort.empty?
    students << {name: name, cohort: cohort.to_sym}
    puts "Now we have #{students.count} #{students.count == 1 ? "student" : "students"}"
    puts "Please enter the name"
    name = gets.tr("\n\r","")
    break if name.empty?
    puts "Please enter cohort"
    cohort = gets.tr("\n\r","")
  end
  students
end

def print_header()
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  if !students.empty?
    counter = 0
    while counter < students.length
      puts "#{students[counter][:name]} (#{students[counter][:cohort]} cohort)"
      counter += 1
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great #{students.count == 1 ? "student" : "students"}"
end

students = input_students()
print_header()
print(students)
print_footer(students)