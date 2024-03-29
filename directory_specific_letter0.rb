# Ask user for input
def input_students
  puts "Please enter the names of the students for the November Cohort"
  puts "To finish, just hit return twice"
  students = []
  name = gets.chomp
  while !name.empty? do
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    puts "Please enter next name..."
    name = gets.chomp
  end
  puts "Enter first letter of student name to print"
  $letter = gets.chomp
  return students
end

# Create print defintions
def print_header
  puts "The students of Villains Academy, with specific letter"
  puts "-------------"
end

def print_names(students)
  students.each_with_index { |student, index|
    if student[:name][0].downcase == $letter.downcase
      puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
  }
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
