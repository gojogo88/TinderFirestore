//
//  RegistrationVC.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2019/01/09.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {

  //UI Components:
  let selectedPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    button.heightAnchor.constraint(equalToConstant: 275).isActive = true
    button.layer.cornerRadius = 16
    return button
  }()
  
  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 44)
    tf.placeholder = "Enter full name"
    tf.backgroundColor = .white
    return tf
  }()

  let emailTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 44)
    tf.placeholder = "Enter email"
    tf.keyboardType = .emailAddress
    tf.backgroundColor = .white
    return tf
  }()

  let passwordTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 44)
    tf.placeholder = "Enter password"
    tf.backgroundColor = .white
    tf.isSecureTextEntry = true
    return tf
  }()
  
  let registerButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Register", for: .normal)
    b.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    b.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
    b.setTitleColor(.white, for: .normal)
    b.heightAnchor.constraint(equalToConstant: 44).isActive = true
    b.layer.cornerRadius = 22
    return b
  }()
  
    override func viewDidLoad() {
        super.viewDidLoad()

      setupGradientLayer()
      //view.backgroundColor = .red
      
      let stackView = UIStackView(arrangedSubviews: [
        selectedPhotoButton,
        fullNameTextField,
        emailTextField,
        passwordTextField,
        registerButton
        ])
      
      view.addSubview(stackView)
      stackView.axis = .vertical
      stackView.spacing = 8
      stackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
  
  func setupGradientLayer() {
    let gradientLayer = CAGradientLayer()
    let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0, 1]
    
    view.layer.addSublayer(gradientLayer)
    gradientLayer.frame = view.bounds
  }

  

}
