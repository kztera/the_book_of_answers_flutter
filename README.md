<h1>The Book of the Answers Flutter app</h1>

<h2>Table of Content</h2>

- [Ý tưởng](#ý-tưởng)
- [TODO](#todo)
- [Các vấn đề cần giải quyết](#các-vấn-đề-cần-giải-quyết)
  - [Làm sao để lấy được dữ liệu từ cuốn sách gốc?](#làm-sao-để-lấy-được-dữ-liệu-từ-cuốn-sách-gốc)
  - [Sử dụng dữ liệu này như thế nào?](#sử-dụng-dữ-liệu-này-như-thế-nào)
  - [Tạo giao diện cho ứng dụng](#tạo-giao-diện-cho-ứng-dụng)
    - [Màn hình chính](#màn-hình-chính)


## Ý tưởng

- Giới thiệu: Là ứng dụng dựa trên cuốn sách The Book of Answers của Carol Bolt. Người dùng sẽ suy nghĩ về một câu hỏi và thực hiện nhấn vào hình ảnh trên màn hình và ứng dụng sẽ đưa ra câu trả lời cho người dùng.
  
- Công nghệ sử dụng: Flutter 

- Cách lưu trữ câu trả lời: File JSON

## TODO

- [x] Lấy câu trả lời từ cuốn sách gốc 
- [ ] Lưu trữ vào đâu để truy xuất dữ liệu?
- [ ] Tạo giao diện cho ứng dụng
  - [ ] Màn hình chính 
  - [ ] Màn hình câu trả lời
  - [ ] Menu Popup
  - [ ] Sliding Side Menu
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

#### Màn hình chính
