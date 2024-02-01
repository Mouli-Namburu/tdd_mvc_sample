import 'dart:io';

void main() {
  createLibFilesFromTest();
}

void createLibFilesFromTest() {
  final testDirectory = Directory('test');

  if (testDirectory.existsSync()) {
    final dartFiles = testDirectory
        .listSync(recursive: true)
        .whereType<File>()
        .where((file) => file.path.endsWith('_test.dart'));

    dartFiles.forEach((testFile) {
      createFileInLib(testFile);
    });
  } else {
    print('The test directory does not exist.');
  }
}

void createFileInLib(File testFile) {
  final fileName = testFile.uri.pathSegments.last.replaceAll('_test.dart', '');
  final relativePath = testFile.uri.pathSegments.skip(1).join('/');
  final libFilePath = 'lib/$relativePath';

  createFolders(libFilePath);
  createFile('$libFilePath/$fileName.dart', fileName);
}

void createFolders(String folderPath) {
  final directory = Directory(folderPath);

  if (!directory.existsSync()) {
    directory.createSync(recursive: true);
    print('Created folder: ${directory.path}');
  }
}

void createFile(String filePath, String fileName) {
  if (!File(filePath).existsSync()) {
    final file = File(filePath);
    file.writeAsStringSync(generateFileContent(fileName));
    print('Created file: ${file.path}');
  } else {
    print('File already exists: $filePath');
  }
}

String generateFileContent(String fileName) {
  return '''
class $fileName {
  // Add your class content here
}
''';
}
