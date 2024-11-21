import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum NetworkStatus { connected, disconnected }

class NetworkCubit extends Cubit<NetworkStatus> {
  final Connectivity _connectivity = Connectivity();
  NetworkCubit() : super(NetworkStatus.disconnected) {
    _monitorNetwork();
  }
  late final StreamSubscription<List<ConnectivityResult>> _subscription;

  void _monitorNetwork() {
    _subscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.first == ConnectivityResult.none) {
        emit(NetworkStatus.disconnected);
      } else {
        emit(NetworkStatus.connected);
      }
    }, onError: (error) {
      print("Error listening to connectivity: $error");
    });
  }

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
