import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '34.174.165.102',
         user = 'root',
         password = 'theSp0t@69',
         db = 'parkingLotdb';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db
    );
    return await MySqlConnection.connect(settings);
  }
}