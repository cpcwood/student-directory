# Ask user for input
def input_students
  puts "Please enter the names and ages and cohorts of the students"
  puts "To finish, just hit return twice"
  students = []
  possible_cohorts = ['January', 'Febuary', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

  while true
    puts "Please student name"
    name = gets.strip.capitalize
    if !name.empty?
      # Enter age
      puts "Please enter age of student"
      age = gets.strip
      # Enter cohort
      puts "Please enter student cohort"
      cohort = gets.strip.capitalize
      until cohort.empty?
        if possible_cohorts.any? {|s| s == cohort}
          break
        else
          puts "Input incorrect\n Please enter student cohort"
          cohort = gets.strip.capitalize
        end
      end

      # Merge defaults
      student = {name: name, age: age, cohort: cohort}
      default = {age: '--', cohort: 'December'}
      students << default.merge(student) {|key, default, student| student.empty? ? default : student}

      # Add to students list
      puts "Now we have #{students.count} students"
    else
      break
    end
  end
  return students
end

# Create print defintions
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names(students)
  if students.length > 0
    i = 0
    while i < students.length
      puts "#{i + 1}. #{(students[i][:name]).center(16)} Age: #{(students[i][:age]).center(2)} (#{students[i][:cohort]} cohort)"
      i += 1
    end
    puts "-------------"
  end
end

def print_footer(students)
  print "Overall, we have #{students.count} great student"
  if students.count > 1
    print "s\n"
  end
end

# Run program
students = input_students
print_header
print_names(students)
print_footer(students)
