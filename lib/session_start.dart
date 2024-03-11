import "package:artistic_swimming_app/dao/session_dao.dart";
import "package:artistic_swimming_app/dtc.dart";
import "package:artistic_swimming_app/model/user.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class SessionStartPage extends StatefulWidget {
  const SessionStartPage({super.key});

  @override
  State<StatefulWidget> createState() => SessionStartPageState();
}

class SessionStartPageState extends State<SessionStartPage> {
  final _controller = TextEditingController();

  bool? _valid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Session indítása"),
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
                  labelText: "Session neve",
                  hintText: "Kérlek add meg a session nevét",
                  errorText: _valid == null || _valid! ? null : "A session neve nem lehet üres",
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
                    Provider.of<SessionDao>(context, listen: false).insertOne(
                      SessionEntity(
                        name: _controller.text,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DtcPage(),
                      ),
                    );
                  }
                },
                child: const Text("Kész"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
