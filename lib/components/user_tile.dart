import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';

class UserTitle extends StatelessWidget {
  final User user;

  const UserTitle(this.user);

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
    ? CircleAvatar(child: Icon(Icons.person))
    : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FORM, 
                arguments: user
              );
            }, 
            color: Colors.orange,
            icon: Icon(Icons.edit)
            ),
          IconButton(
            onPressed: () {
              showDialog(context: context, builder: (ctx) => AlertDialog(
                title: Text('Excluir Usuário'),
                content: Text('Essa ação não poderá ser desfeita, Tem certeza?'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Não'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  FlatButton( 
                    child: Text('Sim'),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                  ],
                ),
              ).then((confirmed) {
                  if(confirmed) {
                    Provider.of<Users>(context, listen: false).remove(user);
                  };
              });
            }, 
            color: Colors.red,
            icon: Icon(Icons.delete)),
        ]),
      ),
    );
  }
}