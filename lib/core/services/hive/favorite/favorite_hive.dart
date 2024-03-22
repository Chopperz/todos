import 'package:hive/hive.dart';

import 'src/favorite_type/favorite_type.dart';

export 'package:hive/hive.dart';

part 'src/favorite_repository.dart';

class FavoriteHive extends _FavoriteRepository {
  static final FavoriteHive _instance = FavoriteHive._();

  FavoriteHive._();

  factory FavoriteHive() => _instance;

  static const String favorite_box_key = "favorite-box-key";

  static const int favorite_box_id = 1;

  static Future<void> initialize() async {
    await Hive.openLazyBox<FavoriteHiveType>(favorite_box_key);

    Hive.registerAdapter(FavoriteHiveTypeAdapter());
  }

  @override
  Future<void> getMyFavorites() => super.getMyFavorites();
}