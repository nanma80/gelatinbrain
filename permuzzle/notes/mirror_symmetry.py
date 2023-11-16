def replace_text(input_string):
    replacements = {
        'B': 'C',
        'C': 'B'
    }

    # Use a list comprehension to replace text based on the mappings
    replaced_string = ''.join(replacements.get(char, char) for char in input_string)

    return replaced_string

input_string = input("Enter a string: ")
result = replace_text(input_string)

print("Mirror string, remember to flip primes:")
print(result)

