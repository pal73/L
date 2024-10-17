import re

input_str = input("введите строку")
reversed_str = input_str[::-1]

if input_str == reversed_str:
    print("The entered string is symmetrical")
else:
    print("The entered string is not symmetrical")

if re.match("^(\w+)\Z", input_str) and input_str == input_str[::-1]:
    print("The entered string is palindrome")
else:
    print("The entered string is not palindrome")
