//
//  RegistrationVC.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2019/01/09.
//  Copyright © 2019 Appdelight. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class RegistrationVC: UIViewController, UITextFieldDelegate {

  //UI Components:
  let scrollView = UIScrollView()
  
  let selectPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Select Photo", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 32, weight: .heavy)
    button.backgroundColor = .white
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 16
    button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
    button.imageView?.contentMode = .scaleAspectFill
    button.clipsToBounds = true
    return button
  }()
  
  lazy var selectPhotoButtonWidthAnchor = selectPhotoButton.widthAnchor.constraint(equalToConstant: 275)
  lazy var selectPhotoButtonHeightAnchor = selectPhotoButton.heightAnchor.constraint(equalToConstant: 275)
  
  let fullNameTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 50)
    tf.placeholder = "Enter full name"
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  let emailTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 50)
    tf.placeholder = "Enter email"
    tf.keyboardType = .emailAddress
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  let passwordTextField: CustomTextField = {
    let tf = CustomTextField(padding: 24, height: 50)
    tf.placeholder = "Enter password"
    tf.isSecureTextEntry = true
    tf.addTarget(self, action: #selector(handleTextChange), for: .editingChanged)
    return tf
  }()
  
  var activeTextField: CustomTextField?
  
  let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Register", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
    //        button.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
    button.backgroundColor = .lightGray
    button.setTitleColor(.gray, for: .disabled)
    button.isEnabled = false
    button.heightAnchor.constraint(equalToConstant: 44).isActive = true
    button.layer.cornerRadius = 22
    button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    return button
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
    selectPhotoButton,
    verticalStackView
    ])
  
  let gradientLayer = CAGradientLayer()
  
  let registrationViewModel = RegistrationViewModel()
  
  let registeringHUD = JGProgressHUD(style: .dark)
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupNotificationObservers()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupGradientLayer()
    setupLayout()
    setupTapGesture()
    setupRegistrationViewModelObserver()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    //NotificationCenter.default.removeObserver(self)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    gradientLayer.frame = view.bounds
  }
  
  private func textFieldDidBeginEditing(_ textField: CustomTextField) {
    activeTextField = textField
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
    view.addSubview(scrollView)
    scrollView.fillSuperview()
    scrollView.contentSize = view.frame.size
    
    scrollView.addSubview(overallStackView)
    overallStackView.axis = .horizontal
    selectPhotoButton.widthAnchor.constraint(equalToConstant: 275).isActive = true
    overallStackView.spacing = 8
    overallStackView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
    overallStackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
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
    registrationViewModel.bindableisFormValid.bind { [unowned self] (isFormValid) in
      guard let isFormValid = isFormValid else { return }
      self.registerButton.isEnabled = isFormValid
      self.registerButton.backgroundColor = isFormValid ? #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1) : .lightGray
      self.registerButton.setTitleColor(isFormValid ? .white : .gray, for: .normal)
    }
//    registrationViewModel.isFormValidObserver = { [unowned self] (isFormValid) in
//      self.registerButton.isEnabled = isFormValid
//      if isFormValid {
//        self.registerButton.backgroundColor = #colorLiteral(red: 0.8235294118, green: 0, blue: 0.3254901961, alpha: 1)
//        self.registerButton.setTitleColor(.white, for: .normal)
//      } else {
//        self.registerButton.backgroundColor = .lightGray
//        self.registerButton.setTitleColor(.gray, for: .normal)
//      }
//    }
    
    registrationViewModel.bindableImage.bind { [unowned self] (img) in self.selectPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
    }
//    registrationViewModel.imageObserver = { [unowned self] (img) in
//      self.selectedPhotoButton.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
//    }
    
    registrationViewModel.bindableIsRegistering.bind { [unowned self] (isRegistering) in
      if isRegistering == true {
        self.registeringHUD.textLabel.text = "Register"
        self.registeringHUD.show(in: self.view)
      } else {
        self.registeringHUD.dismiss()
      }
    }
  }
  
  @objc fileprivate func handleSelectPhoto() {
    let imagePickerController = UIImagePickerController()
    imagePickerController.delegate = self
    present(imagePickerController, animated: true)
    self.handleDismissKeybaord()
  }
  
  
  
  @objc fileprivate func handleRegister() {
    self.handleDismissKeybaord()
    registrationViewModel.performRegistration { [weak self] (err) in
      if let err = err {
        self?.showHUDWithError(error: err)
        return
      }
      print("Finished registering our user")
    }
  }
  
  fileprivate func showHUDWithError(error: Error) {
    registeringHUD.dismiss()
    let hud = JGProgressHUD(style: .dark)
    hud.textLabel.text = "Failed registration"
    hud.detailTextLabel.text = error.localizedDescription
    hud.show(in: self.view)
    hud.dismiss(afterDelay: 4)
  }
  
  @objc fileprivate func handleKeyboardShow(notification: Notification) {
    //how to figure out height of keyboard
    guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
    let keyboardFrame = value.cgRectValue
    scrollView.contentInset.bottom = keyboardFrame.height
    scrollView.scrollIndicatorInsets.bottom = keyboardFrame.height
  
    // automatically scroll to visible active text field
    guard let activeTextField = activeTextField else { return }
    let visibleRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
    scrollView.scrollRectToVisible(visibleRect, animated: true)
  }
  
  @objc fileprivate func handleKeyboardHide() {
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
      self.view.transform = .identity
    })
  }
  
  @objc fileprivate func handleDismissKeybaord() {
    self.view.endEditing(true) // dismisses keyboard
  }

  @objc fileprivate func handleTextChange(textField: UITextField) {
    if textField == fullNameTextField {
      registrationViewModel.fullName = textField.text
    } else if textField == emailTextField {
      registrationViewModel.email = textField.text
    } else {
      registrationViewModel.password = textField.text
    }
  }
}

extension RegistrationVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let image = info[.originalImage] as? UIImage
    registrationViewModel.bindableImage.value = image
    dismiss(animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
