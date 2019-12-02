# Ask user for input
def input_students
  puts "Please enter the names and ages of the students for the November Cohort"
  puts "To finish, just hit return twice"
  puts "Please enter first name..."
  students = []
  name = gets.strip
  unless name.empty?
    puts "Please enter age of student"
    age = gets.strip
  end
  while !name.empty? do
    students << {name: name, cohort: :november, age: age}
    puts "Now we have #{students.count} students"
    puts "Please enter next name..."
    name = gets.strip
    unless name.empty?
      puts "Please enter age of student"
      age = gets.strip
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
      puts "#{i + 1}. #{(students[i][:name]).center(16)} Age: #{(students[i][:age]).center(4)} (#{students[i][:cohort]} cohort)"
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
