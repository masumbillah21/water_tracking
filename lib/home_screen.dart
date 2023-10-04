import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:water_tracking/water_tracking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _totalConsume = 0;
  final List<WaterTracking> _waterTracking = [];
  final TextEditingController _textEditingController =
      TextEditingController(text: "1");

  Future<void> _showMyDialog(int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Warning!'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Do you really want to delete?.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: () {
                _deleteData(index);
                Navigator.of(context).pop();
              },
              child: const Text('YES'),
            ),
          ],
        );
      },
    );
  }

  void _savingData() {
    setState(() {
      int number = int.parse(_textEditingController.text);
      _totalConsume += number;
      _waterTracking.add(
        WaterTracking(
          dateTime: DateTime.now(),
          numOfGlass: number,
        ),
      );
      _textEditingController.text = "1";
    });
  }

  void _deleteData(int index) {
    setState(() {
      _totalConsume -= _waterTracking[index].numOfGlass;
      _waterTracking.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Total Consume",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "$_totalConsume",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: _textEditingController,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _savingData();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _waterTracking.length,
                itemBuilder: (context, index) => Card(
                  elevation: 4,
                  child: ListTile(
                    onLongPress: () {
                      _showMyDialog(index);
                    },
                    leading: CircleAvatar(
                      child: Text("${index + 1}"),
                    ),
                    title: Text(DateFormat("dd-MM-yyyy hh:mm:ss a")
                        .format(_waterTracking[index].dateTime)),
                    trailing: Text(
                      "${_waterTracking[index].numOfGlass}",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
