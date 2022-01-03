import 'package:observer/observer.dart';

class ObserverExample with Observer {
  int value = 0;

  ObserverExample(this.value);

  //updates gets called when observable gets observed and observable notifies
  @override
  void update(Observable observable, Object arg) {
    //check which observable called update
    switch (observable.runtimeType) {
      case ObservableExample:
        value = arg as int;
        break;
      case ResetObservable:
        value = 0;
        break;
    }
  }
}

class ObservableExample with Observable {
  // wrapper function to prevent casting errors
  void setObserver(int number) {
    notifyObservers(number);
  }
}

class ResetObservable with Observable {}

main() {
  //create observer
  final observer0 = ObserverExample(0);
  final observer1 = ObserverExample(1);

  //create observable and both observer
  final observable = ObservableExample();
  observable.addObserver(observer0);
  observable.addObserver(observer1);

  //create another observable but only add one observer
  final resetObservable = ResetObservable();
  observable.addObserver(observer0);

  //notifies all observer
  observable.notifyObservers(42);

  //resets all observer (here only observer 0)
  resetObservable.notifyObservers(0);
}
