// dao/person_dao.dart

import 'package:floor/floor.dart';
import 'package:weather_app/network/Response/git_model.dart';

@dao
abstract class PostResponseDao {
  @Query('SELECT name FROM Repo WHERE id = 0')
  Future<Repo?> findAllRepo();

  @Query('SELECT * FROM Repo WHERE id = :id')
  Stream<Repo?> findRepoById(int id);

  @insert
  Future<void> insertRepo(Repo repo);

  @update
  Future<void> updateRepo(Repo repo);
}