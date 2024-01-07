import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/widgets.dart';

class ConnectivityService with ChangeNotifier, WidgetsBindingObserver {
  late bool is_Online;
  bool isFirstLaunch = true;

  ConnectivityService() {
    is_Online = false;
    WidgetsBinding.instance.addObserver(this);

    // Listen for changes in connectivity status
    ConnectivityWrapper.instance.onStatusChange.listen((status) {
      is_Online = status == ConnectivityStatus.CONNECTED;

      // Notify listeners when connectivity status changes (excluding the first launch)
      if (!isFirstLaunch) {
        notifyListeners();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle state changes (e.g., when the app is resumed)
    if (state == AppLifecycleState.resumed && isFirstLaunch) {
      isFirstLaunch = false;
      notifyListeners();
    }
  }

  bool get isOnline => is_Online;

  @override
  void dispose() {
    // Remove the observer when the object is disposed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
