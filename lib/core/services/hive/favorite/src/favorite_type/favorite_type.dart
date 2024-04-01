
import '../../favorite_hive.dart';

part 'favorite_type.g.dart';

@HiveType(typeId: FavoriteHive.favorite_box_id)
class FavoriteHiveType extends HiveObject {
  FavoriteHiveType({
    this.id,
    this.name,
    this.order,
  });

  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int? order;
}
