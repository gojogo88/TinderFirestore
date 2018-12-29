//
//  ViewController.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let topStackView = TopNavigationStackView()
  let cardDeckView = UIView()
  let bottomStackView = HomeBottomControlStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
//    let subviews = [UIColor.gray, UIColor.darkGray, UIColor.black].map { (color) -> UIView in
//      let v = UIView()
//      v.backgroundColor = color
//      return v
//    }
//
//    let topStackView = UIStackView(arrangedSubviews: subviews)
//    topStackView.distribution = .fillEqually
//    topStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    setupLayout()
    
    setupDummyCards()
  }

  // MARK:- Setup
  fileprivate func setupLayout() {
    let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomStackView])
    overallStackView.axis = .vertical
    
    view.addSubview(overallStackView)
    overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    overallStackView.isLayoutMarginsRelativeArrangement = true
    overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
    overallStackView.bringSubviewToFront(cardDeckView)
  }
  
  fileprivate func setupDummyCards() {
    let cardView = CardView(frame: .zero)
    cardDeckView.addSubview(cardView)
    cardView.fillSuperview()
  }
  
}

