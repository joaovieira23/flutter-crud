// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:flutter_crud/views/user_form.dart';
import 'package:flutter_crud/views/user_list.dart';
import 'package:provider/provider.dart'; 
import 'views/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // MultiProvider(providers: [],) - Para multiplos providers
    return ChangeNotifierProvider(
      create: (ctx) => Users(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        AppRoutes.HOME: (_) => UserList(),
        AppRoutes.USER_FORM: (_) => UserForm()
      },
    ));
  }
}