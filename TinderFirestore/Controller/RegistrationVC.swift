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
  
  lazy var selectPhotoButtonWidthAnchor = selectedPhotoButton.widthAnchor.constraint(equalToConstant: 275)
  lazy var selectPhotoButtonHeightAnchor = selectedPhotoButton.heightAnchor.constraint(equalToConstant: 275)
  
  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 44)
    tf.placeholder = "Enter full name"
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    return tf
  }()

  let emailTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 44)
    tf.placeholder = "Enter email"
    tf.keyboardType = .emailAddress
    tf.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    tf.backgroundColor = .white
    return tf
  }()

  let passwordTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 44)
    tf.placeholder = "Enter password"
    tf.backgroundColor = .white
    tf.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
    tf.isSecureTextEntry = true
    return tf
  }()
  
  let registerButton: UIButton = {
    let b = UIButton(type: .system)
    b.setTitle("Register", for: .normal)
    b.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    //b.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
    b.backgroundColor = .lightGray
    b.setTitleColor(.gray, for: .disabled)
    b.setTitleColor(.white, for: .normal)
    b.isEnabled = false
    b.heightAnchor.constraint(equalToConstant: 44).isActive = true
    b.layer.cornerRadius = 22
    return b
  }()
  
  lazy var verticalStackView: UIStackView = {
    let sv =  UIStackView(arrangedSubviews: [
      fullNameTextField,
      emailTextField,
      passwordTextField,
      registerButton
      ])
    sv.axis = .vertical
    sv.distribution = .fillEqually
    sv.spacing = 8
    return sv
  }()
  
  lazy var overallStackView = UIStackView(arrangedSubviews: [
    selectedPhotoButton,
    verticalStackView
    ])
  
  let gradientLayer = CAGradientLayer()
  
  let registrationViewModel = RegistrationViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupGradientLayer()
    setupLayout()
    setupNotificationObservers()
    setupTapGesture()
    setupRegistrationViewModelObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gradientLayer.frame = view.bounds
  }
  
  // MARK:- Setup
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    if self.traitCollection.verticalSizeClass == .compact {
      overallStackView.axis = .horizontal
      verticalStackView.distribution = .fillEqually
      selectPhotoButtonHeightAnchor.isActive = false
      selectPhotoButtonWidthAnchor.isActive = true
    } else {
      overallStackView.axis = .vertical
      verticalStackView.distribution = .fill
      selectPhotoButtonWidthAnchor.isActive = false
      selectPhotoButtonHeightAnchor.isActive = true
    }
  }
  
  fileprivate func setupLayout() {
    view.addSubview(overallStackView)
    overallStackView.axis = .horizontal
    selectedPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
    overallStackView.spacing = 8
    overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
    overallStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
  }
  
  fileprivate func setupGradientLayer() {
    let topColor = #colorLiteral(red: 0.9921568627, green: 0.3568627451, blue: 0.3725490196, alpha: 1)
    let bottomColor = #colorLiteral(red: 0.8980392157, green: 0, blue: 0.4470588235, alpha: 1)
    gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
    gradientLayer.locations = [0, 1]
    
    view.layer.addSublayer(gradientLayer)
    gradientLayer.frame = view.bounds
  }

  fileprivate func setupNotificationObservers() {
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  fileprivate func setupTapGesture() {
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismissKeybaord)))
  }
  
  fileprivate func setupRegistrationViewModelObserver() {
    registrationViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
      
      self.registerButton.isEnabled = isFormValid
      if isFormValid {
        self.registerButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
        self.registerButton.setTitleColor(.white, for: .normal)
      } else {
        self.registerButton.backgroundColor = .lightGray
        self.registerButton.setTitleColor(.gray, for: .normal)
      }
    }
  }
  
  @objc fileprivate func handleKeyboardShow(notification: Notification) {
    //how to figure out height of keyboard
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.cgRectValue
  
    //let's try to figure out how tall the gap is from the register button to the bottom of the screen
    let bottomSpace = view.frame.height - overallStackView.frame.origin.y - overallStackView.frame.height
  
    let difference = keyboardFrame.height - bottomSpace
    self.view.transform = CGAffineTransform(translationX: 0, y: -difference - 8)
  }
  
  @objc fileprivate func handleKeyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.transform = .identity
    })
  }
  
  @objc fileprivate func handleDismissKeybaord() {
    self.view.endEditing(true)
  }

  @objc fileprivate func handleTextChanged(textField: UITextField) {
    if textField == fullNameTextField {
      registrationViewModel.fullName = textField.text
    } else if textField == passwordTextField {
      registrationViewModel.email = textField.text
    } else {
      registrationViewModel.password = textField.text
    }
  }
}
