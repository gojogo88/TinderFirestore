//
//  HomeVC.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class HomeVC: UIViewController {

  let topStackView = TopNavigationStackView()
  let cardDeckView = UIView()
  let bottomControls = HomeBottomControlStackView()
  
  /*
  let users = [
    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
    User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")
  ]
 */
  
  /*
  let cardViewModels = [
    CardViewModel.userToCardViewModel(user: User(name: "kelly", age: 23, profession: "Music DJ", imageNames: ["kelly1", "kelly2", "kelly3"])),
    CardViewModel.userToCardViewModel(user: User(name: "Jane", age: 18, profession: "Teacher", imageNames: ["jane1", "jane2", "jane3"])),
    CardViewModel.advertiserToCardViewModel(advertiser: Advertiser(title: "Kit Kat", brandName: "Nestle", posterPhotoName: "pillow-book"))

    /*
    User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c").toCardViewModel(),
    User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c").toCardViewModel()
 */
  ]
 */
  
  var cardViewModels = [CardViewModel]() // empty array
  
  var lastFetchedUser: User?
  
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
    topStackView.settingsButton.addTarget(self, action: #selector(handleSettings), for: .touchUpInside)
    bottomControls.refreshButton.addTarget(self, action: #selector(handleRefresh), for: .touchUpInside)
    setupLayout()
    setupFirestoreUserCards()
    fetchUsersFromFirestore()
  }

  // MARK:- Setup
  fileprivate func setupLayout() {
    view.backgroundColor = .white
    let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardDeckView, bottomControls])
    overallStackView.axis = .vertical
    
    view.addSubview(overallStackView)
    overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    overallStackView.isLayoutMarginsRelativeArrangement = true
    overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
    overallStackView.bringSubviewToFront(cardDeckView)
  }
  
  fileprivate func setupFirestoreUserCards() {
    
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
  
  fileprivate func fetchUsersFromFirestore() {
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Fetching Users"
    hud.show(in: view)
    let query = Firestore.firestore().collection("users").order(by: "uid").start(after: [lastFetchedUser?.uid ?? ""]).limit(to: 2)
    query.getDocuments { (snapshot, err) in
      hud.dismiss()
      if let err = err {
        print("Failed to fetch users", err)
        return
      }
      
      snapshot?.documents.forEach({ (documentSnapshot) in
        let userDictionary = documentSnapshot.data()
        let user = User(dictionary: userDictionary)
        self.cardViewModels.append(CardViewModel.userToCardViewModel(user: user))
        self.lastFetchedUser = user
        self.setupCardFromUser(user: user)
      })
      //self.setupFirestoreUserCards()
    }
  }
  
  fileprivate func setupCardFromUser(user: User) {
    let cardView = CardView(frame: .zero)
    cardView.cardViewModel = CardViewModel.userToCardViewModel(user: user)
    cardDeckView.addSubview(cardView)
    cardDeckView.sendSubviewToBack(cardView)
    cardView.fillSuperview()
  }
  
  @objc func handleSettings() {
    let settingsVC = SettingsVC()
    let navController = UINavigationController(rootViewController: settingsVC)
    present(navController, animated: true)
  }
  
  @objc fileprivate func handleRefresh() {
    fetchUsersFromFirestore()
  }
  
}

