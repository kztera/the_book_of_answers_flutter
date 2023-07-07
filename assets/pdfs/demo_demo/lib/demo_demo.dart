import 'dart:io';

List<String> readFileToList(String filePath) {
  // Create an empty list to store the file contents
  List<String> contentList = [];

  try {
    // Open the file for reading
    File file = File(filePath);
    // Read the contents of the file as lines
    List<String> lines = file.readAsLinesSync();
    
    // Add each line to the content list
    for (String line in lines) {
      contentList.add(line);
    }
  } catch (e) {
    print('Error reading file: $e');
  }

  return contentList;
}

