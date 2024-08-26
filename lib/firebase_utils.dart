import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_test/model/task.dart';

class FirebaseUtils{
  static CollectionReference<Task>  getTasksCollection(){
    return FirebaseFirestore.instance.collection('tasks')
        .withConverter<Task>(
        fromFirestore: ((snapshot , option) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,option) => task.toFireStore());
  }
  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection() ;
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id ;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFormFireStore(Task task ){
    return getTasksCollection().doc(task.id).delete();
  }
  static Future<void> updateTaskToFireStore(Task taskobj) async {
    try {
      var taskCollection = getTasksCollection();
      var taskDocRef = taskCollection.doc(taskobj.id);
      await taskDocRef.update(taskobj.toFireStore());
    } catch (e) {
      print('Failed to update task: $e');
      throw e;
    }
  }
}