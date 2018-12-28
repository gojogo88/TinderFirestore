//
//  HomeBottomControlStackView.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class HomeBottomControlStackView: UIStackView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    
    distribution = .fillEqually
    heightAnchor.constraint(equalToConstant: 100).isActive = true

    let subViews = [#imageLiteral(resourceName: "refresh_circle"), #imageLiteral(resourceName: "dismiss_circle"), #imageLiteral(resourceName: "super_like_circle"), #imageLiteral(resourceName: "like_circle"), #imageLiteral(resourceName: "boost_circle")].map { (img) -> UIView in
      let button = UIButton(type: .system)
      button.setImage(img.withRenderingMode(.alwaysOriginal), for: .normal)
      return button
    }
    
    //bottom row of buttons
    /*
    let bottomSubViews = [UIColor.red, .green, .yellow, .orange, .purple].map { (color) -> UIView in
      let v = UIView()
      v.backgroundColor = color
      return v
    }
 */
    
    subViews.forEach { (v) in
      addArrangedSubview(v)
    }
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
