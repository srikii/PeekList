import 'package:flutter/material.dart';
//import 'package:peeklist/pages/create_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peeklist/pages/create_task.dart';
import 'package:peeklist/pages/inbox.dart';
import 'package:peeklist/models/tasklist.dart';
import 'package:peeklist/pages/tasklistpage.dart';
import 'package:peeklist/utils/auth.dart';
import 'package:peeklist/pages/show_starred.dart';
import 'package:peeklist/pages/today_page.dart';
import 'package:peeklist/pages/planned_page.dart';
import 'package:peeklist/pages/completed_page.dart';
import 'package:peeklist/data/tasks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../utils/auth.dart';

class TaskPage extends StatefulWidget {
// final FirebaseUser user;

// TaskPage({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<Tasklist> tasklist = [];
  Map<String, dynamic> _profile;
  String docid;
  Set alllists = {};
  final newlist = TextEditingController();
  final renamelist = TextEditingController();

  void _getdata() async {
    var uid = await AuthService().userID();
    Stream<QuerySnapshot> qsp = Firestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .snapshots();
    qsp.forEach((ds) {
      List<DocumentSnapshot> ds1 = ds.documents;
      tasklist.clear();
      ds1.forEach((element) {
        docid = element.documentID;
        for (int i = 0; i < element['tasks'].length; i++) {
          var newlist = Tasklist(listname: element['tasks'][i]);
          tasklist.add(newlist);
          alllists.add(element['tasks'][i]);
        }
      });
      setState(() {
        tasklist;
      });
    });
  }

  gettasklist() {
    List n = tasklist.toList();
    Set re = {};
    for (int i = 0; i < n.length; i++) {
      var strin = n[i].listname;
      re.add(strin);
    }
    return re.toList();
  }

  @override
  void initState() {
    super.initState();

    Future f1 = new Future(() => null);
    f1.then((_) {
      _getdata();
    });

    authService.profile.listen((state) => setState(() => _profile = state));
//_getdata();
  }

// void addTask() {
//   List inbox = _profile['tasks']['inbox'];

// }

  Future _addtomylist(String Listname) async {
    var uid = await AuthService().userID();
    await Firestore.instance.collection('users').document(uid).updateData({
      'tasks': FieldValue.arrayUnion([Listname])
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
              child: Column(children: <Widget>[
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
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 82.0,
                    child: RaisedButton(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () async {
                        var uid = await AuthService().userID();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuildToday(
                                      uid: uid,
                                    )));
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.today,
                              size: 25.0,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            'Today',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 82.0,
                    child: RaisedButton(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () async {
                        var uid = await AuthService().userID();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuildStarred(
                                      uid: uid,
                                    )));
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.star,
                              size: 25.0,
                              color: Colors.yellow[600],
                            ),
                          ),
                          Text(
                            'Starred',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
            Row(children: <Widget>[Spacer(), Text(""), Spacer()]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 150.0,
                    height: 82.0,
                    child: RaisedButton(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () async {
                        var uid = await AuthService().userID();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuildInbox(
                                      uid: uid,
                                    )));
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.list,
                              size: 25.0,
                              color: Colors.green[800],
                            ),
                          ),
                          Text(
                            'All',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 151.0,
                    height: 82.0,
                    child: RaisedButton(
                      color: Colors.grey[300],
                      padding: const EdgeInsets.all(8.0),
                      onPressed: () async {
                        var uid = await AuthService().userID();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BuildCompleted(
                                      uid: uid,
                                    )));
                      },
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              Icons.event_available,
                              size: 25.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Done',
                            style: TextStyle(fontSize: 25.0),
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
            Row(children: <Widget>[Spacer(), Text(""), Spacer()]),

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
            Row(children: <Widget>[Spacer(), Text(""), Spacer()]),
            Column(
              children: tasklist.map((lst) {
                return Row(children: <Widget>[
                  Expanded(
                    child: ButtonTheme(
                      child: FlatButton(
                        color: Colors.grey[400],
                        padding: const EdgeInsets.all(8.0),
                        onPressed: () async {
                          var uid = await AuthService().userID();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => tasklistpage(
                                        listname: lst.listname,
                                        uid: uid,
                                      )));
                        },
                        onLongPress: () async {
                          var uid = await AuthService().userID();
                          showBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                    color: Colors.grey[400],
                                    height: 100,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(10.0),
                                              topRight:
                                                  const Radius.circular(10.0))),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            RaisedButton(
                                              child: Text("rename"),
                                              color: Colors.blue[100],
                                              disabledColor: Colors.blue[100],
                                              onPressed: () async {
                                                var l = lst.listname;
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      // return object of type Dialog
                                                      return AlertDialog(
                                                        title:
                                                            Text("Rename $l ?"),
                                                        content: TextField(
                                                          decoration:
                                                              InputDecoration(
                                                                  labelText:
                                                                      'Rename this list to?'),
                                                          controller:
                                                              renamelist,
                                                        ),
                                                        actions: <Widget>[
                                                          // usually buttons at the bottom of the dialog
                                                          FlatButton(
                                                            child:
                                                                Text("Cancel"),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                          FlatButton(
                                                            child:
                                                                Text("rename"),
                                                            onPressed:
                                                                () async {
                                                              await ListMethod()
                                                                  .rename_list(
                                                                      uid,
                                                                      lst
                                                                          .listname,
                                                                      renamelist
                                                                          .text);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                            ),
                                            RaisedButton(
                                              color: Colors.red,
                                              disabledColor: Colors.red,
                                              child: Text("Delete"),
                                              onPressed: () async {
                                                var l = lst.listname;
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    // return object of type Dialog
                                                    return AlertDialog(
                                                      title: Text("Delete $l?"),
                                                      content: Text(
                                                          "Deleting this list will remove all tasks in the list."),
                                                      actions: <Widget>[
                                                        // usually buttons at the bottom of the dialog
                                                        FlatButton(
                                                          child: Text("Cancel"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        FlatButton(
                                                          child: Text("Delete"),
                                                          onPressed: () async {
                                                            await ListMethod()
                                                                .delete_list(
                                                                    uid,
                                                                    lst.listname);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ]),
                                    ),
                                  ));
                        },
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.folder,
                                size: 25.0,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              lst.listname,
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ])),
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blue,
        animatedIcon: AnimatedIcons.view_list,
        children: [
          SpeedDialChild(
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            backgroundColor: Colors.orange[900],
            child: Icon(Icons.create),
            label: "Create new list",
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
// return object of type Dialog
                    return AlertDialog(
                      title: Text("Create New User List"),
                      content: TextField(
                        decoration: InputDecoration(labelText: 'list name'),
                        controller: newlist,
                      ),
                      actions: <Widget>[
// usually buttons at the bottom of the dialog
                        FlatButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("create list"),
                          onPressed: () async {
                            await _addtomylist(newlist.text);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
          SpeedDialChild(
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            backgroundColor: Colors.green,
            child: Icon(Icons.add),
            label: "add task",
            onTap: () async {
              var uid = await AuthService().userID();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CreateTask(choose_list: 'inbox', uid: uid)),
              );
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
