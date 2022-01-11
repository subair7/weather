// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:weather_app/network/Response/git_model.dart';
import 'package:weather_app/network/floor/post_response_dao.dart';


part 'app_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Repo])
abstract class AppDatabase extends FloorDatabase {
  PostResponseDao get postResponseDao;
}