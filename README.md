# Observable-Swift-Protocol

Mainly used in situation when you need to hold many delegates (without strong references) and call some method for each.

```swift
protocol PlayerObserver: AnyObject  {
	func someMethod()
}

class Player: NSObject, Observable, AVAudioPlayerDelegate {
	typealias ObserverType = PlayerObserver // protocol

	var observers: [() -> PlayerObserver?] = []

	func somethigChanged() {
		send { $0.someMethod() }  // call someMethot on all available observers
	}
}
```
