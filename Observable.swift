//
//  Observable.swift
//  
//
//  Created by Robert Koval on 11/22/19.
//  Copyright © 2019 Robert Koval. All rights reserved.
//

import Foundation

protocol Observable: AnyObject {
	associatedtype ObserverType
	typealias WeakObject = () -> ObserverType?
	var observers: [() -> ObserverType?] { get set }

	func register(_ object: ObserverType)
	func unregister(_ object: ObserverType)
	func send(_ completion: (ObserverType) -> Void)

}


extension Observable {
	func register(_ object: ObserverType) {
		weak var weakObject = object as AnyObject
		observers.append({ weakObject as? ObserverType })
	}

	func unregister(_ object: ObserverType) {
		guard let index = observers.firstIndex(where: {
			($0() as AnyObject?) === (object as AnyObject?)
		}) else { return }
		let _ = observers.remove(at: index)
	}

	func send(_ completion: (ObserverType) -> Void) {
		observers.forEach { item in
			guard let object = item() else { return }
			completion(object)
		}
	}
}


