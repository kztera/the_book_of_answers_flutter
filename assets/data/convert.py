import json

# Read the text file
with open('answers.txt', 'r') as file:
    lines = file.read().splitlines()

# Create a dictionary to store the data
data = {'answer': []}

# Add the phrases to the dictionary
for i, line in enumerate(lines):
    phrase = {'id': i + 1, 'answer': line}
    data['answer'].append(phrase)

# Write the data to a JSON file
with open('answers.json', 'w') as file:
    json.dump(data, file, indent=4)
