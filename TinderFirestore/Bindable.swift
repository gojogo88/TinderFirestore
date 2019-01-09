//
//  Bindable.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2019/01/09.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import Foundation

class Bindable<T> {
  var value: T? {
    didSet {
      observer?(value)
    }
  }
  
  var observer: ((T?)->())?
  
  func bind(observer: @escaping (T?) -> ()) {
    self.observer = observer
  }
}
