import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:todo_sql/helper/DatabaseHelper.dart';

class DatabaseController extends GetxController {
  DatabaseHelper dbHelper = DatabaseHelper();
  RxList employeList = [].obs;
  @override
  void onInit() {
    super.onInit();
    initDatabase();
  }

  void initDatabase() async {
    await dbHelper.initDatabase();
    getEmployes();
  }

  void getEmployes() async {
    employeList.value = await dbHelper.fetchData();
  }

  void addData(String name, String salary, String role) async {
    await dbHelper.insertData(name, salary, role);
    getEmployes();
  }

  void delData(int id) async {
    await dbHelper.deleteData(id);
    getEmployes();
  }
}
