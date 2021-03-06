require 'csv'
@students = []

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp())
  end
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  load_students(filename)
end

def load_students(filename = "students.csv")
  if File.exists?(filename)
    CSV.foreach(filename) do |row|
      name, cohort = row
      add_students(name, cohort)
    end
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist. Trying default file."
    load_students
  end
end

def get_load_filename
  puts "Please confirm the name of the file you want to load or press enter for default"
  filename = STDIN.gets.chomp
  if filename.empty?
    puts "Loading default file, if available"
    load_students()
  else
    load_students(filename)
  end
end


def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    add_students(name)
    puts "Now we have #{@students.count} #{@students.count == 1 ? "student" : "students"}"
    name = STDIN.gets.chomp
  end
end

def add_students(name, cohort = "november")
  @students << {name: name, cohort: cohort.to_sym}
end

def save_students
  puts "Please enter file name you would like to use or press enter for default"
  filename = STDIN.gets.chomp()
  filename = "students" if filename.empty?
  CSV.open("#{filename}.csv", "w") do |csv|
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv << student_data
    end
  end
  puts "Saved student records to #{filename}.csv"
end

def process(selection)
  case selection
    when "1"
      puts "Student input"
      input_students()
    when "2"
      puts "Displaying students"
      show_students()
    when "3"
      puts "Saving student list to file"
      save_students()
    when "4"
      puts "Loading student list from file"
      get_load_filename()
    when "9"
      puts "Goodbye"
      exit
    else
      puts "I don't know what you meant, try again"
  end
end

def show_students
  print_header()
  print_students_list()
  print_footer()
end

def print_menu
  puts "1. Input students"
  puts "2. Show students"
  puts "3. Save the list to file"
  puts "4. Load the list from file"
  puts "9. Exit"
end



def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_students_list()
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer()
  puts "Overall, we have #{@students.count} great #{@students.count == 1 ? "student" : "students"}"
end

interactive_menu