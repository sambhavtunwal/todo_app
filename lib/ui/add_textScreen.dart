import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/database/database_helpers.dart';

class AddTaskScreen extends StatefulWidget {
  final Function updateTaskList;
  final Task task;

  const AddTaskScreen({Key key, this.task, this.updateTaskList})
      : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final _formKey = GlobalKey<FormState>();
  String _todos = "";


  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _todos = widget.task.todos;
          }
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      print("$_todos");

      // insert task to the database
      Task task = Task(todos: _todos);
      if (widget.task == null) {
        DatabaseHelper.instance.insertTask(task);
      } else {
        //update the task
        task.id = widget.task.id;

      }
      widget.updateTaskList();
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 35,
                        color: Color(0xFFff6961),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(widget.task == null ? "Add Task" : "Update Task",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'PopinsBold',
                        )),
                  ],
                ),
                SizedBox(
                  key: _formKey,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18.0),
                            decoration: InputDecoration(
                              labelText: "Title",
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            validator: (input) => input.trim().isEmpty
                                ? "Please enter a task title"
                                : null,
                            onSaved: (input) => _todos = input,
                            initialValue: _todos,
                          ),
                        ),


                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20.0),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 12,
                          decoration: BoxDecoration(
                            color: Color(0xFFff6961),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: FlatButton(
                            onPressed: _submit,
                            child: Text( "Add",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontFamily: 'PopinsBolds')),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
