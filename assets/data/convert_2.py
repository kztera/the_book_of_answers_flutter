import json

def generate_json(en_file, vi_file, output_file):
    with open(en_file, 'r', encoding='utf-8') as en_file, open(vi_file, 'r', encoding='utf-8') as vi_file:
        en_texts = [line.strip() for line in en_file.readlines()]
        vi_texts = [line.strip() for line in vi_file.readlines()]

    answer_list = []
    max_length = max(len(en_texts), len(vi_texts))

    for i in range(max_length):
        answer = {
            'id': i + 1,
            'answerTexts': {
                'en': en_texts[i] if i < len(en_texts) else '',
                'vi': vi_texts[i] if i < len(vi_texts) else ''
            }
        }
        answer_list.append(answer)

    json_data = {
        'answer': answer_list
    }

    with open(output_file, 'w', encoding='utf-8') as output_file:
        json.dump(json_data, output_file, indent=4)

    print('JSON file created successfully.')


generate_json('answers_en.txt', 'answers_vi.txt', 'answers_2.json')
