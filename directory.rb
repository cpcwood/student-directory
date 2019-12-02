# Ask user for input
def input_students
  puts "Please enter the names and ages and cohorts of the students"
  puts "To finish, just hit return twice"
  pos_cohort = [['January', 1], ['Febuary', 2], ['March', 3], ['April', 4], ['May', 5], ['June', 6], ['July', 7], ['August', 8], ['September', 9], ['October', 10], ['November', 11], ['December', 12]]

  while true
    puts "Please student name"
    name = gets.strip.capitalize
    if !name.empty?
      # Enter additional info
      puts "Please enter age of student"
      age = gets.strip
      puts "Please enter student cohort"
      cohort = gets.strip.capitalize
      until cohort.empty?
        if pos_cohort.any? {|s| s[0] == cohort}
          break
        else
          puts "Input incorrect\n Please enter student cohort"
          cohort = gets.strip.capitalize
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
  # Sort by cohort
  $students = $students.sort{|a, b| pos_cohort.find{|s| /#{a[:cohort]}/ =~ s[0]}[1] <=> pos_cohort.find{|s| /#{b[:cohort]}/ =~ s[0]}[1]}
end

# Create print defintions
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names
  if $students.length > 0
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
  file = File.open("students.csv", "w")
  $students.each do |student|
    student_data = [student[:name], student[:age], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "\nStudent directory saved to \"students.csv\"\n\n"
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, age, cohort = line.chomp.split(',')
    $students << {name: name, cohort: cohort, age: age}
  end
  file.close
  puts "\nStudent directory loaded from\"students.csv\"\n\n"
end

def process_selection(selection)
  # Print menu and check input
  case (selection)
  when "1"
    $students = input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

# Create interactive menu
def interactive_menu
  $students = []
  loop do
    print_menu
    process_selection(gets.chomp)
  end
end

# Run progam
interactive_menu
