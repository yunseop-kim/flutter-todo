import 'package:flutter/material.dart';
import './addItemScreen.dart';

void main() => runApp(new TabBarDemo());

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.today)),
                Tab(icon: Icon(Icons.done))
              ],
            ),
            title: Text('Todo List'),
          ),
          body: TabBarView(
            children: [TodoList(), Icon(Icons.directions_transit)],
          ),
        ),
      ),
    );
  }
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'Todo List', home: new TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  createState() => new TodoListState();
}

class TodoTile {
  String title;
  DateTime date;
  bool done;

  TodoTile(String title) {
    this.title = title;
    this.date = new DateTime.now();
    this.done = false;
  }
}

class TodoListState extends State<TodoList> {
  List<TodoTile> _todoItems = [];

  Widget _buildToDoList() {
    return new ListView.builder(itemBuilder: (context, index) {
      if (index < _todoItems.length) {
        return _buildToDoItem(_todoItems[index], index);
      }
    });
  }

  Widget _buildToDoItem(TodoTile todo, int index) {
    return new CheckboxListTile(
      title: Text(todo.title),
      subtitle: Text(todo.date.toString()),
      value: todo.done,
      onChanged: (bool value) {
        setState(() => _todoItems.elementAt(index).done = value);
      },
      secondary: const Icon(Icons.info),
    );
  }

  _addTodoItem(TodoTile todo) {
    setState(() {
      _todoItems.add(todo);
    });
  }

  _navigatorAddItemScreen() async {
    Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) {
        return AddItemScreen();
      },
    ));

    if (results != null && results.containsKey("item")) {
      _addTodoItem(new TodoTile(results["item"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildToDoList(),
      floatingActionButton: new FloatingActionButton(
          onPressed: _navigatorAddItemScreen,
          tooltip: '추가',
          child: new Icon(Icons.add)),
    );
  }
}
