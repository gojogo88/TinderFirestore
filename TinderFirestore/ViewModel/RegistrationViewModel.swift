//
//  RegistrationViewModel.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2019/01/09.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class RegistrationViewModel {
  var fullName: String? {
    didSet {
      checkFormValidity()
    }
  }
  var email: String? {
    didSet {
      checkFormValidity()
    }
  }
  var password: String? {
    didSet {
      checkFormValidity()
    }
  }
  
  fileprivate func checkFormValidity() {
    let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
    isFormValidObserver?(isFormValid)
  }
  
  //reactive programming
  var isFormValidObserver: ((Bool) -> ())?
}
