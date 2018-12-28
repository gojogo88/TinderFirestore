//
//  TopNavigationStackView.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

  let settingsButton = UIButton(type: .system)
  let messageButton = UIButton(type: .system)
  let fireImageView = UIImageView(image: #imageLiteral(resourceName: "app_icon").withRenderingMode(.alwaysOriginal))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    fireImageView.contentMode = .scaleAspectFit
    settingsButton.setImage(#imageLiteral(resourceName: "top_left_profile").withRenderingMode(.alwaysOriginal), for: .normal)
    messageButton.setImage(#imageLiteral(resourceName: "top_right_messages").withRenderingMode(.alwaysOriginal), for: .normal)
    
    [settingsButton, UIView(), fireImageView, UIView(), messageButton].forEach { (v) in
      addArrangedSubview(v)
    }
    
    distribution = .equalCentering
    heightAnchor.constraint(equalToConstant: 80).isActive = true
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
    
//    let buttons = [#imageLiteral(resourceName: "top_left_profile"), #imageLiteral(resourceName: "app_icon"), #imageLiteral(resourceName: "top_right_messages")].map { (img) -> UIView in
//      let button = UIButton(type: .system)
//      button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
//      return button
//    }
//
//    buttons.forEach { (v) in
//      addArrangedSubview(v)
//    }
    
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
