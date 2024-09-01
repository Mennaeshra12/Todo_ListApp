import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_test/model/my_user.dart';
import 'package:todo_test/model/task.dart';

class FirebaseUtils{
  static CollectionReference<Task>  getTasksCollection(String uId){
    return getUsersCollection().doc(uId).collection('tasks')
        .withConverter<Task>(
        fromFirestore: ((snapshot , option) => Task.fromFireStore(snapshot.data()!)),
        toFirestore: (task,option) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task , String uId) {
    var taskCollection = getTasksCollection(uId) ;
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id ;
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFormFireStore(Task task , String uId ){
    return getTasksCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateTaskToFireStore(Task taskobj, String uId) async {
    try {
      var taskCollection = getTasksCollection(uId);
      var taskDocRef = taskCollection.doc(taskobj.id);
      await taskDocRef.update(taskobj.toFireStore());
    } catch (e) {
      print('Failed to update task: $e');
      throw e;
    }
  }

  static CollectionReference<MyUser> getUsersCollection(){
    return FirebaseFirestore.instance.collection(MyUser.collectionName)
        .withConverter<MyUser>(
        fromFirestore: ((snapshot,options) => MyUser.fromFireStore(snapshot.data()!)),
        toFirestore: (user ,_) => user.toFireStore()) ;
  }

  static Future<void> addUserToFireStore(MyUser myUser){
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?>readUserFromFireStore(String uId) async{
    var snapshot = await getUsersCollection().doc(uId).get();
    return snapshot.data();
  }

}