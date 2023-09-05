# --  Opening a file --

fhand = open('daffodils.txt')
print(fhand)


# -- Printing a file--

# Get the file handler
fhand = open('daffodils.txt')
# Loop through each line via file handler
for line in fhand:
  print(line) 


# -- Checking special characters --

# Get the file handler
fhand = open('daffodils.txt')
# Loop through each line via file handler
for line in fhand:
  print(line) 

  
# -- Printing a file w/o extra lines using print() --
  
  # Get the file handler
fhand = open('daffodils.txt')
# Loop through each line and modify the default value of 'end'
for line in fhand:
  print(line, end = '')


# -- Printing a file w/o extra lines using repr() --

# Get the file handler
fhand = open('daffodils.txt')
# Loop through each line and remove extra line character with rstrip()
for line in fhand:
  line = line.rstrip()
  print(line)


# -- Letting the user choose a file
fname = input('Enter the file name: ')
fhand = open(fname)
count = 0
for line in fhand:
     count = count + 1
print('There are', count, 'lines in', fname)


# -- Writing to a file --

# Writing
# Open file with mode 'w'
fout = open('flower.txt', 'w')
fout.write("This content would be added and existing would be discarded")
fout.close()

# Appending
# Open file with mode 'a'
fout = open('flower.txt', 'a')
fout.write("Now the file has more content at the end!")
fout.close()

# Creating and appending
# Open file with mode 'x'
fout = open('new-file.txt', 'x')
fout.write("Now the new file has some content!")
fout.close()


# -- Exception handling
fname = input('Enter the file name: ')
try:
  fhand = open(fname)
except:
  print('File not found and can not be opened:', fname)
  exit()
count=0
for line in fhand:
  count = count + 1
print('There are', count, 'lines in', fname)