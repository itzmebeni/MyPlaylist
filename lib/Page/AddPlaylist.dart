import 'package:flutter/material.dart';

class AddPlaylist extends StatefulWidget {
  const AddPlaylist({super.key});

  @override
  State<AddPlaylist> createState() => _AddPlaylistState();
}
final _formKey = GlobalKey<FormState>();
String _name = '';
String _description = '';
int _rate = 0;

class _AddPlaylistState extends State<AddPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[300],
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Add Playlist'),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    labelText: 'Male or Female?',
                  ),
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return 'Please add a name';
                      }
                      return null;
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    labelText: 'Are you Dark or Super Dark?',
                  ),
                    validator: (value){
                      if(value == null || value.isEmpty) {
                        return 'Please add a name';
                      }
                      return null;
                    }
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightBlue),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      labelText: 'Do You Have Stinky Smell or Killer Smell?'
                  ),
                  validator: (value){
                    if(value == null || value.isEmpty) {
                      return 'Please add a name';
                    }
                    return null;
                  }
                ),
              ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SizedBox(
              width: double.infinity, // makes it stretch horizontally
              height: 50, // optional: gives it a good height
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print('The form is Validated');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}

