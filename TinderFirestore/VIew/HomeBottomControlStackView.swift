//
//  HomeBottomControlStackView.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class HomeBottomControlStackView: UIStackView {

  static func createButton(image: UIImage) -> UIButton {
    let button = UIButton(type: .system)
    button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    button.imageView?.contentMode = .scaleAspectFill
    return button
  }
  
  let refreshButton = createButton(image: #imageLiteral(resourceName: "refresh_circle"))
  let dislikeButton = createButton(image: #imageLiteral(resourceName: "dismiss_circle"))
  let superlikeButton = createButton(image: #imageLiteral(resourceName: "super_like_circle"))
  let likeButton = createButton(image: #imageLiteral(resourceName: "like_circle"))
  let specialButton = createButton(image: #imageLiteral(resourceName: "boost_circle"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    distribution = .fillEqually
    heightAnchor.constraint(equalToConstant: 100).isActive = true

    [refreshButton, dislikeButton, superlikeButton, likeButton, specialButton].forEach { (button) in
      self.addArrangedSubview(button)
    }
    /*
    let subViews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in
      let button = UIButton(type: .system)
      button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
      return button
    }
    
    //bottom row of buttons
    
    let bottomSubViews = [UIColor.red, .green, .yellow, .orange, .purple].map { (color) -> UIView in
      let v = UIView()
      v.backgroundColor = color
      return v
    }
 */
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
