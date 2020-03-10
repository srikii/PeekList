import 'package:flutter/material.dart';
import 'package:peeklist/pages/create_task.dart';
import 'package:peeklist/pages/inbox.dart';
import 'package:peeklist/models/tasklist.dart';
import 'package:peeklist/pages/tasklistpage.dart';

class TaskPage extends StatefulWidget {
  // final FirebaseUser user;

  // TaskPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Tasklist> tasklist = [
    Tasklist(listname: 'schooltask'),
    //Tasklist(listname: 'groceries')
  ];

  final newtasklistinputController = TextEditingController();

  void _addtomylist(String lstname) {
    final newlst = Tasklist(listname: lstname);

    setState(() {
      tasklist.add(newlst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    "Task Page",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Row(children: <Widget>[
                Icon(
                  Icons.inbox,
                  color: Colors.green,
                  size: 30.0,
                ),
                RaisedButton(
                    child: Text('Inbox'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BuildInbox()));
                    }),
              ]),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    "My Lists",
                    style: TextStyle(
                      fontSize: 25.0,
                    ),
                  ),
                ),
              ),
              Card(
                  elevation: 5,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                            decoration:
                                InputDecoration(labelText: 'new list name'),
                            controller: newtasklistinputController,
                          ),
                          RaisedButton(
                            child: Text('create list'),
                            textColor: Colors.blue,
                            onPressed: () {
                              //print(newtasklistinputController.text);
                              _addtomylist(newtasklistinputController.text);
                            },
                          )
                        ],
                      ))),
              Column(
                children: tasklist.map((lst) {
                  return FlatButton(
                      child: Text(lst.listname),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => tasklistpage()));
                      });
                }).toList(),
              ),
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateTask()),
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

//Widget _buildBody(BuildContext context){
//  return StreamBuilder<QuerySnapshot>(
//    stream: Firestore.instance.collection('tasks').where('list',isEqualTo: 'inbox').snapshots(),
//     builder: (context, snapshot) {
//      if(!snapshot.hasData) return Container();
//      return _buildList(context,snapshot.data.documents);
//     },
//  );
//}
//
//Widget _buildList(BuildContext context,List<DocumentSnapshot> list){
//  return ListView.builder(
//      itemCount: list.length,
//      itemBuilder: (context,idx){
//        DocumentSnapshot doc =list[idx];
//        return ListTile(
//          title: Text(doc['name']),
//          subtitle: Text(doc['comment']),
//        );
//      }
//  );
//}
