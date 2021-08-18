import 'package:capcee/models/user_model.dart';
import 'package:capcee/services/web_services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List data = [];
  bool loading = false;
  @override
  void initState() {
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    final result = await Webservices().getData();
    if (result.statusCode == 200) {
      data = result.data.map((user) => User.fromJson(user)).toList();
      /* print(data[0].name); */
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {},
          child: Icon(
            Icons.edit,
            color: Colors.grey[500],
          )),
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.grey,
        ),
        title: Text(
          'Contacts',
          style: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Icon(
            Icons.search,
            color: Colors.grey,
          ),
          SizedBox(
            width: size.width * 0.03,
          )
        ],
      ),
      body: Container(
        /* padding: EdgeInsets.symmetric(horizontal: size.width * 0.04), */
        child: loading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white,
                        radius: size.width * 0.065,
                        child: Icon(
                          Icons.person,
                          size: 30,
                        ),
                      ),
                      title: Text(data[index].name),
                      subtitle: Text(data[index].company.catchPhrase),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
