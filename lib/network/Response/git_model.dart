// entity/person.dart

import 'package:floor/floor.dart';

@entity
class Repo {
  @primaryKey
  final int? id;

  final String? name;


  Repo(
      {this.id,
      this.name,
      });
}
