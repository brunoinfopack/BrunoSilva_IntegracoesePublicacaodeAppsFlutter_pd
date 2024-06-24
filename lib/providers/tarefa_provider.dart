import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_tarefa_pk/projeto_tarefa_pk.dart';

class TarefaProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String collection = "tarefas";

  List<Tarefa> tarefass = [];

  //int number = 0;

  void addTarefas(Tarefa tarfs) {
    tarefass.add(tarfs);
    notifyListeners();
  }

  list() {
    db.collection(collection).get().then((QuerySnapshot qs) {
      for (var doc in qs.docs) {
        var tfs = doc.data() as Map<String, dynamic>;
        DateTime dt = (tfs['dataHora'] as Timestamp).toDate();
        tfs['dataHora'] = dt;
        tarefass.add(Tarefa.fromMap(doc.id, tfs));
        notifyListeners();
      }
    });
  }

  insert(Tarefa tarfs) {
    var data = <String, dynamic>{
      'nome': tarfs.nome,
      'dataHora': tarfs.dataHora,
      'geolocalizacao': tarfs.geolocalizacao
    };

    var future = db.collection(collection).add(data);

    future.then((DocumentReference doc) {
      String id = doc.id;
      tarfs.id = id;
      tarefass.add(tarfs);
      notifyListeners();
    });
  }

  update(Tarefa tarfs) {
    var data = <String, dynamic>{
      'nome': tarfs.nome,
      'dataHora': tarfs.dataHora,
      'geolocalizacao': tarfs.geolocalizacao
    };

    db.collection(collection).doc(tarfs.id).update(data);
    notifyListeners();
  }

  delete(Tarefa tarfs) {
    var future = db.collection(collection).doc(tarfs.id).delete();
    future.then((_) {
      tarefass.remove(tarfs);
      notifyListeners();
    });
  }
}
