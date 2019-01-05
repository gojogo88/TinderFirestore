//
//  HomeVC.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

  let topStackView = TopNavigationStackView()
  let cardDeckView = UIView()
  let bottomStackView = HomeBottomControlStackView()
  
  /*
  let users = [
    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
    User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")
  ]
 */
  
  let cardViewModels = [
    CardViewModel.userToCardViewModel(user: User(name: "kelly", age: 23, profession: "Music DJ", imageName: "lady5c")),
    CardViewModel.userToCardViewModel(user: User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")),
    CardViewModel.advertiserToCardViewModel(advertiser: Advertiser(title: "Kit Kat", brandName: "Nestle", posterPhotoName: "pillow-book"))

    /*
    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c").toCardViewModel(),
    User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c").toCardViewModel()
 */
  ]
  
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
    
    cardViewModels.forEach { (cardVM) in
      let cardView = CardView(frame: .zero)
      
      cardView.cardViewModel = cardVM
//      cardView.imageView.image = UIImage(named: cardVM.imageName)
//      cardView.informationLabel.attributedText = cardVM.attributedString
//      cardView.informationLabel.textAlignment = cardVM.textAlignment
      
      cardDeckView.addSubview(cardView)
      cardView.fillSuperview()
    }
    /*
    users.forEach { (user) in
      let cardView = CardView(frame: .zero)
      cardView.imageView.image = UIImage(named: user.imageName)
      //cardView.informationLabel.text = "\(user.name) \(user.age)\n\(user.profession)"
      
      let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
      attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
      attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 22, weight: .regular)]))
      
      cardView.informationLabel.attributedText = attributedText
 
    
      cardDeckView.addSubview(cardView)
      cardView.fillSuperview()
 
    }
 */
  }
  
}

