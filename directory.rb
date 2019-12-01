# Create array of all students
students = [
  "Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

# Create print defintions
def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names(names)
  puts names
  puts "-------------"
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

# Run program
print_header
print_names(students)
print_footer(students)
