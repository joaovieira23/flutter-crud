import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:provider/provider.dart'; 

class UserForm extends StatefulWidget {

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if(user !== null) {

    _formData['id'] = user.id,
    _formData['name'] = user.name,
    _formData['email'] = user.email,
    _formData['avatarUrl'] = user.avatarUrl,
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = ModalRoute.of(context)?.settings.arguments as User;
    
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid =_form.currentState?.validate();

              if(isValid ?? false) {
                _form.currentState?.save();


                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _form,

          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return 'Nome inválido';
                  }

                  if(value.trim().length < 3) {
                    return 'O nome deve ter no mínimo 3 letras';
                  }

                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: 'E-mail'),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: 'URL do Avatar'),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      )
    );
  }
}