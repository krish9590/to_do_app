import 'package:flutter/material.dart';

import '../constrains/colors.dart';
import '../models/todo.dart';
import '../widgets/to_do_items.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<ToDo> todosList = ToDo.todoList();
  final _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: tdBGColor,
          appBar: _buildAppBar(),
          body: Stack(children: [
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  children: [
                    searchBox(),
                    Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 20),
                            child: const Text('All ToDos',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          for (ToDo todoo in todosList)
                            ToDoItem(
                              todo: todoo,
                              onToDoChanged: _handleToDoChange,
                              onDeleteItem: _deleteToDoItem,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        bottom: 20,
                        right: 20,
                        left: 20,
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        controller: _todoController,
                        decoration: const InputDecoration(
                            hintText: 'add a new to do items',
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _addToDoItem(_todoController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tdBlue,
                        minimumSize: const Size(60, 60),
                        elevation: 10,
                      ),
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  )
                ],
              ),
            )
          ])),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String toDo) {
    setState(() {
      todosList.add(
        ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          todoText: toDo,
        ),
      );
    });
    _todoController.clear();
  }

}

Widget searchBox() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: const TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: Icon(
          Icons.search,
          color: tdBlack,
          size: 20,
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: tdGrey),
      ),
    ),
  );
}

AppBar _buildAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: tdBGColor,
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Icon(
        Icons.menu,
        color: tdBlack,
        size: 30,
      ),
      SizedBox(
        height: 40,
        width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(21),
          child: Image.asset("assets/images/profilePic.jpg"),
        ),
      )
    ]),
  );
}
