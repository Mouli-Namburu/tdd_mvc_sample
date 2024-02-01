import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../controllers/user_controller.dart';

class HomePage extends StatelessWidget {

  final http.Client client;

  const HomePage({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(client: client),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomeView> {
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _userController = Provider.of<UserController>(context, listen: false);
    _userController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body: Consumer<UserController>(
        builder: (context, controller, child) {
          if (controller.users.isEmpty) {
            // If the user list is empty, fetch users
            controller.fetchUsers();
            return const Center(child: CircularProgressIndicator());
          } else {
            // If the user list is not empty, display user names in cards
            return ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(controller.users[index].name),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
