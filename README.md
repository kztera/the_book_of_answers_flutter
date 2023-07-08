<h1>The Book of the Answers Flutter app</h1>

<h2>Table of Content</h2>

- [Ý tưởng](#ý-tưởng)
- [TODO](#todo)
- [Các vấn đề cần giải quyết](#các-vấn-đề-cần-giải-quyết)
  - [Làm sao để lấy được dữ liệu từ cuốn sách gốc?](#làm-sao-để-lấy-được-dữ-liệu-từ-cuốn-sách-gốc)
  - [Sử dụng dữ liệu này như thế nào?](#sử-dụng-dữ-liệu-này-như-thế-nào)
  - [Tạo giao diện cho ứng dụng](#tạo-giao-diện-cho-ứng-dụng)
  - [Chuyện Load dữ liệu](#chuyện-load-dữ-liệu)
    - [Tiếng Việt và Tiếng Anh](#tiếng-việt-và-tiếng-anh)

## Ý tưởng

- Giới thiệu: Là ứng dụng dựa trên cuốn sách The Book of Answers của Carol Bolt. Người dùng sẽ suy nghĩ về một câu hỏi và thực hiện nhấn vào hình ảnh trên màn hình và ứng dụng sẽ đưa ra câu trả lời cho người dùng.

<p align="center"><img src="assets/images/Icon.png" 
        alt="App Icon" 
        width="400"/></p>

<p align="center"><i>App icon</i></p>

- Công nghệ sử dụng: Dart/Flutter 

- Cách lưu trữ câu trả lời: File JSON

## TODO

- [x] Lấy câu trả lời từ cuốn sách gốc 
- [x] Lưu trữ vào đâu để truy xuất dữ liệu?
- [ ] Tạo giao diện cho ứng dụng
  - [x] Màn hình chính 
  - [x] Màn hình câu trả lời
  - [x] Menu Popup chọn ngôn ngữ
  - [x] Sliding Side Menu
- [ ] Chức năng lưu lịch sử câu trả lời

## Các vấn đề cần giải quyết

Với kiến thức về Dart và Flutter bằng 0 và khả năng lập trình cơ bản có sẵn, mình sẽ bóc tách các bước thành các vấn đề nhỏ để research cũng như vừa làm vừa học luôn :) Nếu bất kì ai có cách giải quyết, tối ưu hệ thống thì cứ góp ý thoải mái bằng cách tạo pull request nha ^^ Mình rất biết ơn vì điều này

### Làm sao để lấy được dữ liệu từ cuốn sách gốc?

Lướt Github một lúc, ta dễ dàng có thể thấy được file txt bao gồm 171 câu trả lời tại [đây](https://github.com/masonfocus/TheBookOfAnswers/blob/master/answers.txt). Tuy nhiên khi so sánh với cuốn sách gốc được bán lên tới 709 trang. Rõ ràng đây là một bộ dữ liệu chưa được đầy đủ cho lắm nên có lẽ ta kiếm cuốn sách gốc và lấy nội dung từ đó .

Dễ dàng tìm thấy cuốn sách bản PDF được tái bản khá mới tại [Scribd](https://www.scribd.com/document/621821644/The-Book-of-Answers-1). Để tải luôn thay vì đăng nhập này nọ chúng ta có thể sử dụng trang web [này](https://scribd.vdownloaders.com/) vì chỉ việc cóp link đó vào và tải về thôi.

Bản tải về thì đương nhiên là PDF, ngó qua một chút thì thấy nó có định dạng khá đơn giản, mỗi câu trả lời thì được in ở đúng 1 trang. Sử dụng [PDF to Text](https://pdftotext.com/) để chuyển câu trả lời thành file txt. File nhận được thì chưa hẳn là sạch. Cần chút thời gian để làm sạch, ta sẽ có được file txt cuối cùng [answers.txt](assets/data/answers.txt) với 350 câu trả lời.

File có dạng như sau:

```text
YOU WILL NOT BE DISAPPOINTED
SHOW YOUR APPRECIATION
YOUR ACTIONS WILL IMPROVE THINGS
DON’T BET ON IT
ADOPT AN ADVENTUROUS ATTITUDE
FOLLOW THE ADVICE OF EXPERTS
YOU COULD FIND YOURSELF UNABLE TO COMPROMISE
FOCUS ON YOUR HOME LIFE
INVESTIGATE AND THEN ENJOY IT
DEFINITELY
```

### Sử dụng dữ liệu này như thế nào?

Ý tưởng ban đầu là sử dụng hàm chuyển nội dung từ file txt qua `List<String>`. Khi lấy câu trả lời, ta thực hiện truy xuất ngẫu nhiên vào `List<String>` này. 

Tuy nhiên là mình làm không được nên thôi :') Đành chuyển qua dạng json với cấu trúc là id kèm câu trả lời. Khi mà random câu hỏi thì ta chỉ cần random id và lấy câu trả lời tương ứng.

### Tạo giao diện cho ứng dụng

Ứng dụng sẽ chia làm 2 màn hình chính:
- Start Screen: Màn hình chính, khi người dùng nhấn vào bìa cuốn sách thì sẽ chuyển sang màn hình câu trả lời
- Answer Screen: Màn hình hiện câu trả lời, người dùng có thể quay lại màn hình trước đó bằng cách bấm vào nút xem thêm câu trả lời khác

Ngoài ra, ta cần có một menu popup để người dùng có thể chọn xem lịch sử câu trả lời hoặc chia sẻ câu trả lời đó. Cơ mà tạm thời ta chưa cần nghĩ tới điều đó vội, trước hết cần hoàn thành mạch logic chính giữa 2 màn hình chính phía trên trước.

### Chuyện Load dữ liệu

Ý tưởng ban đầu là tạo một class Answer:

```Dart
class Answer {
  late String answer;
  late int id;

  Answer({required this.answer, required this.id});
}
```

Đọc file Json và truyền vào một `List<Answer>`:

```Dart
Future<List<Answer>> readJsonFile() async {
  try {
    String jsonPath = 'assets/data/answers.json';
    String jsonString = await rootBundle.loadString(jsonPath);
    List<dynamic> jsonList = json.decode(jsonString)['answer'];

    List<Answer> answers = [];
    for (var jsonObject in jsonList) {
      Answer answer = Answer(
        answer: jsonObject['answer'],
        id: jsonObject['id'],
      );
      answers.add(answer);
      log('Answer: ${answer.answer} (${answer.id})');
    }

    return answers;
  } catch (e) {
    log('Error reading JSON file: $e');
    return [];
  }
}
```

List này sẽ được truyền qua các Screen và sẽ được lấy ngẫu nhiên ở trang `AnswerScreen` tức là chỉ khi bấm vào cuốn sách thì câu trả lời mới thực sự được lấy ra:

```Dart
Answer getRandomAnswer() {
    final random = Random();
    final index = random.nextInt(widget.answers.length);
    return widget.answers[index];
  }
```

Sau khi thử bộ dữ liệu với một file json có dạng như phía dưới được convert từ file txt (với python :D) mọi thứ có vẻ như đã ổn rồi:

```json
{
    "answer": [
        {
            "id": 1,
            "answer": "YOU WILL NOT BE DISAPPOINTED"
        },
        {
            "id": 2,
            "answer": "SHOW YOUR APPRECIATION"
        }
    ]
}
```


Nhưng mình nhận ra mình còn muốn cả một bản tiếng việt nữa, vậy thì ta sẽ phải bắt đầu lại từ đâu đây?

#### Tiếng Việt và Tiếng Anh

Mục tiêu là sẽ chỉ tạo đúng 1 file Json cho bộ dữ liệu, thay vì chia ra nhiều file Json cho riêng ngôn ngữ. Vậy thì trước hết cần thay đổi một chút về class `Answer`:

```Dart
class Answer {
  late int id;
  late Map<String, String> answerTexts;

  Answer({required this.id, required this.answerTexts});
}
```
Khi này thì mỗi một answers sẽ lưu trữ câu trả lời cho từng ngôn ngữ được hỗ trợ, với `language code` có thể là `en`: English hoặc `vi`: Tiếng Việt đóng vai trò là khóa và câu trả lời trả lời bằng ngôn ngữ đó là giá trị.

Đương nhiên là cả file JSON cũng cần thay đổi cho phù hợp với class mới này:

```json
{
    "answer": [
        {
            "id": 1,
            "answerTexts": {
                "en": "YOU WILL NOT BE DISAPPOINTED",
                "vi": "B\u1ea0N S\u1ebc KH\u00d4NG PH\u1ea2I TH\u1ea4T V\u1eccNG \u0110\u00c2U"
            }
        },
        {
            "id": 2,
            "answerTexts": {
                "en": "SHOW YOUR APPRECIATION",
                "vi": "TH\u1ec2 HI\u1ec6N S\u1ef0 \u0110\u00c1NH GI\u00c1 C\u1ee6A B\u1ea0N"
            }
        }
    ]
}
```

Với class mới, file Json mới, ta cũng sẽ cập nhật `List<Answer>` mới

```Dart
Future<List<Answer>> readJsonFile() async {
  try {
    String jsonString = await rootBundle.loadString('assets/data/answers_2.json');
    final data = jsonDecode(jsonString);

    List<Answer> answerList = [];
    for (var item in data['answer']) {
      Map<String, String> answerTexts = Map<String, String>.from(item['answerTexts']);
      Answer answer = Answer(id: item['id'], answerTexts: answerTexts);
      answerList.add(answer);
    }

    return answerList;
  } catch (e) {
    log('Error reading JSON file: $e');
    return []; // Return an empty list in case of an error
  }
}
```

Đồng thời là việc lấy ngẫu nhiên cũng sẽ thay đổi một chút:

```Dart
  String getAnswerText() {
    return currentAnswer!.answerTexts[languageCode] ?? '';
  }
```

Và như vậy, mỗi lần ta cần câu trả lời được đưa ra là ngôn ngữ nào ta chỉ cần thay đổi giá trị biến `languageCode` là được.