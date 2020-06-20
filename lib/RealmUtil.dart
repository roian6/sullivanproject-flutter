import 'package:flutter_realm/flutter_realm.dart';
import 'package:flutterapp/SoundData.dart';
import 'package:uuid/uuid.dart';

class RealmUtil {
  static Realm realm;

  static void init() {
    final configuration = Configuration(inMemoryIdentifier: Uuid().v4());
    Realm.open(configuration).then((value) => realm = value);
  }

  static Future _onAdd(SoundData) async {
    await realm.createObject('SoundData', product.toMap(withId: true));
  }

  static Future _onEdit(Product product) async {
    await realm.update(
      'Product',
      primaryKey: product.uuid,
      value: product.toMap(withId: false),
    );
  }

  static Future _onDelete(Product product) async {
    await realm.delete('Product', primaryKey: product.uuid);
  }

  static void _onSearch(String term) {
    Stream<List<Map>> newProducts;

    if (term == null || term.isEmpty) {
      newProducts = realm.subscribeAllObjects('Product');
    } else {
      final query = Query('Product').contains('title', term);
      newProducts = realm.subscribeObjects(query);
    }

    setState(() => products = newProducts.map<List<Product>>(_mapProduct));
  }
}
