def replace_text(input_string):
    replacements = {
        'A': 'B',
        'B': 'C',
        'C': 'A'
    }

    # Use a list comprehension to replace text based on the mappings
    replaced_string = ''.join(replacements.get(char, char) for char in input_string)

    return replaced_string

input_string = input("Enter a string: ")
result = replace_text(input_string)

print("Rotated string:")
print(result)

result2 = replace_text(result)
print("Rotated twice:")
print(result2)
