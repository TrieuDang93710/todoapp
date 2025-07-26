import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile1/api/abs/IToDoItem.dart';
import 'package:mobile1/api/abs/IAddToDo.dart';

final String url = 'https://todoapp-server-v1-0-1.onrender.com';

Future<Response> fetchResponse() async {
  var res = await http.get(Uri.parse('$url/api/v1/todos'));
  if (res.statusCode == 200) {
    var jsonDecoded = await jsonDecode(res.body);
    Response todosFromJson = Response.fromJson(jsonDecoded);
    print("todosFromJson: $todosFromJson");
    return todosFromJson;
  } else {
    throw Exception('Failed to load todos');
  }
}

Future<IAddToDo> createToDo(Map<String, dynamic> json) async {
  var res = await http.post(
    Uri.parse('$url/api/v1/todos'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(json),
  );

  if (res.statusCode == 201) {
    return IAddToDo.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to create todo.');
  }
}

Future<IAddToDo> updateToDo(Map<String, dynamic> json, int id) async {
  var res = await http.patch(
    Uri.parse('$url/api/v1/todos/update/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(json),
  );
  if (res.statusCode == 200) {
    return IAddToDo.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to update todo.');
  }
}

Future<IAddToDo> removeToDo(Map<String, dynamic> json, int id) async {
  var res = await http.patch(
    Uri.parse('$url/api/v1/todos/remove/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(json),
  );

  if (res.statusCode == 200) {
    return IAddToDo.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to remove todo.');
  }
}

Future<IAddToDo> completedToDo(Map<String, dynamic> json, int id) async {
  var res = await http.patch(
    Uri.parse('$url/api/v1/todos/update/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(json),
  );

  if (res.statusCode == 200) {
    return IAddToDo.fromJson(jsonDecode(res.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to completed todo.');
  }
}
