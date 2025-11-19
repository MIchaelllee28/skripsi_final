import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:get/get.dart';

class MqttService extends GetxController {
  static MqttService get to => Get.find();

  late MqttServerClient client;
  
  // MQTT Broker Configuration
  final String broker = 'broker.hivemq.com'; // Free public MQTT broker for testing
  final int port = 1883;
  final String clientId = 'flutter_trainee_${DateTime.now().millisecondsSinceEpoch}';

  @override
  void onInit() {
    super.onInit();
    print('🚀 Initializing MQTT Service...');
    _setupMqttClient();
    connect();
  }

  void _setupMqttClient() {
    client = MqttServerClient.withPort(broker, clientId, port);
    client.logging(on: true); // Enable logging to see what's happening
    client.keepAlivePeriod = 60;
    client.onDisconnected = _onDisconnected;
    client.onConnected = _onConnected;
    
    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;
  }

  Future<void> connect() async {
    print('⏳ Connecting to MQTT broker: $broker:$port');
    
    try {
      await client.connect();
    } on NoConnectionException catch (e) {
      print('❌ MQTT client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('❌ MQTT socket exception - $e');
      client.disconnect();
    }
  }

  void _onConnected() {
    print('✅ MQTT Connected successfully!');
    print('📡 Client ID: $clientId');
  }

  void _onDisconnected() {
    print('⚠️ MQTT Disconnected');
  }

  @override
  void onClose() {
    print('🔌 Closing MQTT connection...');
    client.disconnect();
    super.onClose();
  }
}
