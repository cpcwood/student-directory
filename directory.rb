# Ask user for input
def input_students
  puts "Please enter the names and ages of the students for the November Cohort"
  puts "To finish, just hit return twice"
  puts "Please enter first name..."
  students = []
  name = gets.chomp
  unless name.empty?
    puts "Please enter age of student"
    age = gets.chomp
  end
  while !name.empty? do
    students << {name: name, cohort: :november, age: age}
    puts "Now we have #{students.count} students"
    puts "Please enter next name..."
    name = gets.chomp
    unless name.empty?
      puts "Please enter age of student"
      age = gets.chomp
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
  i = 0
  while i < students.length
    puts "#{i + 1}. #{(students[i][:name]).center(16)} Age: #{(students[i][:age]).center(4)} (#{students[i][:cohort]} cohort)"
    i += 1
  end
  puts "-------------"
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

# Run program
students = input_students
print_header
print_names(students)
print_footer(students)
