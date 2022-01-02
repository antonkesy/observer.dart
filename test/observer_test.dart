import 'package:test/test.dart';

import 'package:observer/observer.dart';

class ObserverTest extends Observer {
  int value = 0;

  ObserverTest(this.value);

  @override
  void update(Observable observable, Object arg) {
    //check which observable called update
    if (observable is ObservableTest) {
      value = arg as int;
    }
  }
}

class ObservableTest extends Observable {
  // wrapper function to prevent casting errors
  void setObserver(int number) {
    notifyObservers(number);
  }
}

class DifferentObservable extends Observable {}

void main() {
  test('two int observer with correct calls', () {
    //create observer
    final observer0 = ObserverTest(0);
    final observer1 = ObserverTest(1);

    //create observable and add both observer
    final observable = ObservableTest();
    observable.addObserver(observer0);
    observable.addObserver(observer1);

    //check observer start values are correct
    expect(observer0.value, 0);
    expect(observer1.value, 1);

    //notify all observers
    observable.setObserver(42);
    expect(observer0.value, 42);
    expect(observer1.value, 42);

    //remove one observer and notify again
    observable.removeObserver(observer0);
    observable.setObserver(73);
    expect(observer0.value, 42);
    expect(observer1.value, 73);
  });

  test('only one observer active', () {
    final observer0 = ObserverTest(0);
    final observer1 = ObserverTest(1);

    final observable = ObservableTest();
    observable.addObserver(observer0);

    expect(observer0.value, 0);
    expect(observer1.value, 1);

    observable.setObserver(42);
    expect(observer0.value, 42);
    expect(observer1.value, 1);
  });

  test('how to handle wrong type of observer', () {
    final observer = ObserverTest(0);

    final observable = DifferentObservable();
    observable.addObserver(observer);

    observable.notifyObservers(42);
    expect(observer.value, 0);
  });

  test('multiple observables', () {
    final observer = ObserverTest(0);

    final observable0 = ObservableTest();
    final observable1 = ObservableTest();
    observable0.addObserver(observer);
    observable1.addObserver(observer);

    expect(observer.value, 0);

    observable0.setObserver(42);
    expect(observer.value, 42);

    observable1.setObserver(73);
    expect(observer.value, 73);
  });
}
