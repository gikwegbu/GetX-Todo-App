import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/app/data/models/task.dart';
import 'package:getx/app/data/services/repository.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final formKey = GlobalKey<FormState>();
  final editCtrl = TextEditingController();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.writeTasks(tasks));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    editCtrl.dispose();
    super.onClose();
  }

  void changeChipIndex(int val) {
    chipIndex.value = val;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void changeDeleting(bool val) {
    deleting.value = val;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containTodo(todos, title)) {
      return false;
    }
    var todo = {"title": title, 'done': false};
    todos.add(todo);
    var newTodo = task.copyWIth(todos: todos);
    int oldIndex = tasks.indexOf(task);
    tasks[oldIndex] = newTodo;
    tasks.refresh();
    return true;
  }

  bool containTodo(List todos, title) =>
      todos.any((element) => element['title'] == title);

  bool addTodo(String title) {
    var todo = {"title": title, "done": false};
    if (doingTodos
        .any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    var doneTodo = {"title": title, "done": true};
    if (doneTodos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingTodos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingTodos,
      ...doneTodos,
    ]);
    var newTask = task.value!.copyWIth(todos: newTodos);
    int oldTask = tasks.indexOf(task.value);
    tasks[oldTask] = newTask;
    tasks.refresh();
  }

  void doneTodo(String title) {
    var doingTodo = {"title": title, "done": false};
    int index = doingTodos.indexWhere((element) => mapEquals<String, dynamic >(doingTodo, element));
    doingTodos.removeAt(index);
    var doneTodo = {"title": title, "done": true};
    doneTodos.add(doneTodo);
    doingTodos.refresh();
    doneTodos.refresh();
  }
}
