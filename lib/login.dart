
import "package:artistic_swimming_app/dao/user_dao.dart";
import "package:artistic_swimming_app/model/user.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "home.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _controller = TextEditingController();

  bool? _valid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "Your name",
                  hintText: "Please enter your name",
                  errorText: _valid == null || _valid! ? null : "Value can't be empty",
                ),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isEmpty) {
                    setState(() {
                      _valid = false;
                    });
                  } else {
                    Provider.of<UserDao>(context, listen: false).insertOne(
                      UserEntity(
                        name: _controller.text,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SynchroHomePage(),
                      ),
                    );
                  }
                },
                child: const Text("Login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
