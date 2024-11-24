import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../view/network/network.dart';
import 'navigation_service.dart';

class ConnectionStatusListener {
  static final ConnectionStatusListener _singleton =
      ConnectionStatusListener._internal();

  ConnectionStatusListener._internal();

  static ConnectionStatusListener getInstance() => _singleton;

  bool hasShownNoInternet = false;
  final Connectivity _connectivity = Connectivity();
  bool hasConnection = false;

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(List<ConnectivityResult> result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    await checkConnection();
  }

  void dispose() {
    connectionChangeController.close();
  }
}

void updateConnectivity(
    dynamic hasConnection, ConnectionStatusListener connectionStatus) {
  print("hasConnection: $hasConnection");

  if (!hasConnection) {
    connectionStatus.hasShownNoInternet = true;
    NavigationService().push(const NoInternetScreen());
  } else {
    if (connectionStatus.hasShownNoInternet) {
      connectionStatus.hasShownNoInternet = false;
      NavigationService().goBack();
    }
  }
}

Future<void> initNoInternetListener() async {
  var connectionStatus = ConnectionStatusListener.getInstance();
  await connectionStatus.initialize();

  if (!connectionStatus.hasConnection) {
    updateConnectivity(false, connectionStatus);
  } else {
    connectionStatus.connectionChange.listen((event) {
      updateConnectivity(event, connectionStatus);
    });
  }
}
