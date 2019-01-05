//
//  User.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/29.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import Foundation

struct User {
  //defining our properties for our model layer
  let name: String
  let age: Int
  let profession: String
  let imageName: String
  
  /*
  func toCardViewModel() -> CardViewModel {
    let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    attributedText.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
    attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]))
    
    return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
  }
 */
}

