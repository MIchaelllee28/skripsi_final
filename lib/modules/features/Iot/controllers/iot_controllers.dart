import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class IotController extends GetxController {
  static IotController get to => Get.find();
  final databaseInt = FirebaseDatabase.instance.ref('test');
  final RxInt _intValue = 0.obs;
  final databaseRelay = FirebaseDatabase.instance.ref('relay');
  final RxBool _relayValue = true.obs;

  @override
  void onInit() {
    super.onInit();

    databaseInt.onValue.listen((event) {
      _intValue.value = event.snapshot.value as int;
    });

    databaseRelay.onValue.listen((event) {
      _relayValue.value = event.snapshot.value as bool;
    });
  }

  void toogleRelay() {
    databaseRelay.set(!_relayValue.value);
  }

  void printIntValue() {
    print("${_intValue.value}");
  }

  // Getter for the value
  RxInt get intValue => _intValue;
  RxBool get relayValue => _relayValue;
}
