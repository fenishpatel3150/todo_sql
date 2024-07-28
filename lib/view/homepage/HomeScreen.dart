import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_sql/controller/DatabaseController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController salaryController = TextEditingController();
    TextEditingController roleController = TextEditingController();
    DatabaseController databaseController = Get.put(DatabaseController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Details'),
        actions: [
          TextButton(
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => AlertDialog(
                  title: Center(
                    child: Text(
                      'ADD DETAILS',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Name'),
                      ),
                      TextField(
                        controller: salaryController,
                        decoration: InputDecoration(labelText: 'Salary'),
                      ),
                      TextField(
                        controller: roleController,
                        decoration: InputDecoration(labelText: 'Role'),
                      ),
                    ],
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (nameController.text.isNotEmpty &&
                                salaryController.text.isNotEmpty &&
                                roleController.text.isNotEmpty) {
                              print('Adding data through controller');
                              databaseController.addData(
                                nameController.text,
                                salaryController.text,
                                roleController.text,
                              );
                              nameController.clear();
                              salaryController.clear();
                              roleController.clear();
                              Navigator.of(context).pop();
                            } else {
                              Get.snackbar(
                                'Error',
                                'All fields are required',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            }
                          },
                          child: Text('Save'),
                        ),
                        TextButton(
                          onPressed: () {
                            nameController.clear();
                            salaryController.clear();
                            roleController.clear();
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'ADD',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Obx(
            () {
          print('Rebuilding ListView with ${databaseController.employeList.length} items');
          if (databaseController.employeList.isEmpty) {
            return Center(child: Text('No employees found.'));
          }
          return ListView.builder(
            itemCount: databaseController.employeList.length,
            itemBuilder: (context, index) {
              var employee = databaseController.employeList[index];
              return ListTile(
                leading: Text(employee['id'].toString()),
                title: Text(employee['name']),
                subtitle: Text(employee['role']),
                trailing: Text(employee['salary'].toString()),
              );
            },
          );
        },
      ),
    );
  }
}
