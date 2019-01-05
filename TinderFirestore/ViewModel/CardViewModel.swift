//
//  CardViewModel.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/29.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
  //associatedtype ModelData
  //associatedtype Advertiser
  static func userToCardViewModel(user: User) -> CardViewModel
  static func advertiserToCardViewModel(advertiser: Advertiser) -> CardViewModel
}

struct CardViewModel: ProducesCardViewModel {

  //properties that our card will display/render out
  let imageNames: [String]
  let attributedString: NSAttributedString
  let textAlignment: NSTextAlignment

  
  static func userToCardViewModel(user: User) -> CardViewModel {
    let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
    attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
    attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
    
    return CardViewModel(imageNames: user.imageNames, attributedString: attributedText, textAlignment: .left)
  }
  
  static func advertiserToCardViewModel(advertiser: Advertiser) -> CardViewModel {
    let attributedText = NSMutableAttributedString(string: advertiser.title, attributes: [.font: UIFont.systemFont(ofSize: 34, weight: .heavy)])
    attributedText.append(NSAttributedString(string: "\n\(advertiser.brandName)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .bold)]))
    
    return CardViewModel(imageNames: [advertiser.posterPhotoName], attributedString: attributedText, textAlignment: .center)
  }
}

