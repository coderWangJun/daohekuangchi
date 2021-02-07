import 'package:event_bus/event_bus.dart';

class EventCenter{
  static EventCenter _instance;

  EventBus _bus;

  void fire(dynamic event) {
    _bus.fire(event);
  }

  void listen<T>(void onData(T event)) {
    _bus.on().listen(onData);
  }

  EventCenter._() {
    _bus = EventBus();
  }

  static EventCenter defaultCenter() {
    if (_instance == null) {
      _instance = EventCenter._();
    }
    return _instance;
  }
}