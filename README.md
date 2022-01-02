Basic dart only observer pattern without any special features.

## Features

- pass context through update arguments

## Usage

- Inheritance from observer/observable
- Add observer to observable instances
- Call notifyObservers form the observable instance

```dart
//create observer
final observer = ObserverX();

//create observable and both observer
final observable = ObservableX();
observable.addObserver(observer);

//notifies all observer
observable.notifyObservers(/*arguments*/);
```

Checkout example or test for detailed information.