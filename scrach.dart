void main() {
  performtask();
}

void performtask() async {
  task1();
  String task2Data = await task2();
  task3(task2Data);
}

void task1() {
  String result = 'Tast 1 data';
  print('task 1 is completed');
}

Future task2() async {
  Duration threeSecands = Duration(seconds: 3);
  String? result;
  await Future.delayed(threeSecands, () {
    result = 'Task 2 data';
    print('Tast 2 is Completed');
  });
  return result!;
}

// Cync
// void taskCync() {
//   String result = 'Tast Cync data';
//   print('task Cync is completed');
// }
// // async

// void taskAcync() {
//   Duration threeSeconds = Duration(seconds: 3);
//   Future.delayed(threeSeconds, () {
//     String result = 'Tast Acync data';
//     print('task Acync is completed is After 3 Secands');
//   });
// }

void task3(String task2Data) {
  String result = 'Tast 3 data';
  print('task 3 is completed');
}
