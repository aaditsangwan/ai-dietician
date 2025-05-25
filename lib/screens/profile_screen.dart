import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String sex = 'male';
  int age = 25;
  int heightFeet = 5;
  int heightInches = 8;
  int weightLbs = 160;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Sex", style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: sex,
                items: ['male', 'female']
                    .map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value[0].toUpperCase() + value.substring(1)),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    sex = val!;
                  });
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age (years)'),
                initialValue: age.toString(),
                keyboardType: TextInputType.number,
                onChanged: (val) => age = int.tryParse(val) ?? age,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Height (ft)'),
                      initialValue: heightFeet.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => heightFeet = int.tryParse(val) ?? heightFeet,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Height (in)'),
                      initialValue: heightInches.toString(),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => heightInches = int.tryParse(val) ?? heightInches,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Weight (lbs)'),
                initialValue: weightLbs.toString(),
                keyboardType: TextInputType.number,
                onChanged: (val) => weightLbs = int.tryParse(val) ?? weightLbs,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Next: Activity Level'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushNamed(
                      context,
                      '/profile/activity',
                      arguments: {
                        'sex': sex,
                        'age': age,
                        'heightFeet': heightFeet,
                        'heightInches': heightInches,
                        'weightLbs': weightLbs,
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
