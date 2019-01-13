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
  var name: String?
  var age: Int?
  var profession: String?
  //let imageNames: [String]
  var imageUrl1: String?
  var uid: String?
  
  init(dictionary: [String: Any]) {
    //we'll initialize our users here
    let name = dictionary["fullname"] as? String ?? ""
    self.age = dictionary["age"] as? Int
    self.profession = dictionary["profession"] as? String
    self.name = name
    
  
    self.imageUrl1 = dictionary["imageUrl1"] as? String ?? ""
    self.uid = dictionary["uid"] as? String ?? ""
  }
  
  /*
  func toCardViewModel() -> CardViewModel {
    let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    attributedText.append(NSAttributedString(string: " \(age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
    attributedText.append(NSAttributedString(string: "\n\(profession)", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]))
    
    return CardViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
  }
 */
}

