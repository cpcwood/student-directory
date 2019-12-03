require 'csv'
# Ask user for input
def input_students
  puts "Please enter the names and ages and cohorts of the students"
  puts "To finish, just hit return twice"
  while true
    puts "Please student name"
    name = STDIN.gets.strip.capitalize.gsub(/,/, '')
    unless name.empty?
      # Enter additional info
      puts "Please enter age of student"
      age = STDIN.gets.strip
      puts "Please enter student cohort"
      cohort = STDIN.gets.strip.capitalize
      until cohort.empty?
        if $pos_cohort.any? {|s| s[0] == cohort}
          break
        else
          puts "Input incorrect\n Please enter student cohort"
          cohort = STDIN.gets.strip.capitalize
        end
      end
      # Merge defaults and ouput number of student
      student = {name: name, age: age, cohort: cohort}
      default = {age: '--', cohort: 'December'}
      $students << default.merge(student) {|key, default, student| student.empty? ? default : student}
      puts "Now we have #{$students.count} students"
    else
      break
    end
  end
end

# Create print defintions
def print_header
  puts "\nThe students of Villains Academy"
  puts "-------------"
end

def print_names
  if $students.length > 0
    $students = $students.sort{|a, b| $pos_cohort.find{|s| /#{a[:cohort]}/ =~ s[0]}[1] <=> $pos_cohort.find{|s| /#{b[:cohort]}/ =~ s[0]}[1]}
    $students.each_with_index {|student, index|
      puts "#{index + 1}. #{(student[:name]).ljust(16)} Age: #{(student[:age]).ljust(2)} (#{student[:cohort]} cohort)"
    }
    puts "-------------"
  end
end

def print_footer
  print "Overall, we have #{$students.count} great student"
  if $students.count > 1
    print "s"
  end
  print "\n\n"
end

# Define interactive menu components
def print_menu
  # Ask user what to do
  puts "Please select option from the following list"
  puts "1 -> Input the students"
  puts "2 -> Show the students"
  puts "3 -> Save students directory"
  puts "4 -> Load student directory from exisiting file"
  puts "9 -> Exit"
end

def show_students
  print_header
  print_names
  print_footer
end

def save_students
  puts "Enter filename for directory, if none entered default of 'students' will be used"
  name = STDIN.gets.strip
  if name == ""
    name = "students"
  end
  CSV.open("#{name}.csv", "w", write_headers: true, headers: $students.first.keys) {|csv|
    $students.each {|student|
      csv << student.values
    }
  }
  puts "\nStudent directory saved to #{name}.csv\n\n"
end

def load_students(filename = "students.csv")
  $students = []
  CSV.foreach(filename, 'r', headers: :first_row, header_converters: :symbol){|row|
    $students << row.to_h
  }
  puts "\nLoaded #{$students.count} students from #{filename}\n\n"
end

def show_databases
  puts "\nAvailable directory databases\n"
  sleep(0.5)
  puts Dir.glob("*.csv")
  puts "\nEnter filename to load from, if none entered default of 'students.csv' will be used"
  filename = STDIN.gets.strip
  filename.empty?? "students.csv" : filename
end

def try_load_students
  puts "Loading previous student directory from default or argument"
  sleep(1)
  ARGV.first.nil?? filename = "students.csv" : filename = ARGV.first
  if File.exists?(filename)
    load_students(filename)
  else
    puts "\nSorry, #{filename} doesn't exist, no students loaded\n\n"
  end
  sleep(1)
end

def process_selection(selection)
  # Print menu and check input
  puts "Option #{selection} selected"
  sleep(1)
  case (selection)
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students(show_databases)
  when "9"
    exit
  else
    puts "I don't know what you meant, please try again"
  end
end

# Create interactive menu
def interactive_menu
  $students = []
  $pos_cohort = [['January', 1], ['Febuary', 2], ['March', 3], ['April', 4], ['May', 5], ['June', 6], ['July', 7], ['August', 8], ['September', 9], ['October', 10], ['November', 11], ['December', 12]]
  try_load_students
  loop do
    print_menu
    process_selection(STDIN.gets.strip)
  end
end

# Run progam
interactive_menu
