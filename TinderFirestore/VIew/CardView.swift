//
//  CardView.swift
//  TinderFirestore
//
//  Created by Jonathan Go on 2018/12/28.
//  Copyright © 2018 Appdelight. All rights reserved.
//

import UIKit

class CardView: UIView {
  
  var cardViewModel: CardViewModel! {
    didSet {
      let imageName = cardViewModel.imageNames.first ?? ""
      imageView.image = UIImage(named: imageName)
      informationLabel.attributedText = cardViewModel.attributedString
      informationLabel.textAlignment = cardViewModel.textAlignment
      
      //some dummy bars
      (0..<cardViewModel.imageNames.count).forEach { (_) in
        let barView = UIView()
        barView.backgroundColor = barDeselectedColor
        barStackView.addArrangedSubview(barView)
      }
      barStackView.arrangedSubviews.first?.backgroundColor = .white
    
      setupImageIndexObserver()
    }
  }

  //encapsulation
  fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c").withRenderingMode(.alwaysOriginal))
  fileprivate let gradientLayer = CAGradientLayer()
  fileprivate let informationLabel = UILabel()
  fileprivate let barStackView = UIStackView()
  
  //Configurations
  fileprivate let threshold: CGFloat = 80
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupLayout()
    
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
    addGestureRecognizer(panGesture)
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    
  }
  
  fileprivate func setupLayout() {
    layer.cornerRadius = 10
    clipsToBounds = true
    contentMode = .scaleAspectFill
    
    addSubview(imageView)
    imageView.fillSuperview()
    
    setupGradientLayer()
    
    setupBarStackView()
    
    addSubview(informationLabel)
    informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
    
    informationLabel.textColor = .white
    informationLabel.numberOfLines = 0
  }
  
  fileprivate func setupGradientLayer() {
    gradientLayer.colors =
    [UIColor.clear.cgColor, UIColor.black.cgColor]
    gradientLayer.locations = [0.5, 1.1]
    // self.frame here is actually zero
    
    layer.addSublayer(gradientLayer)
  }
  
  fileprivate func setupBarStackView() {
    addSubview(barStackView)
    barStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
    barStackView.spacing = 4
    barStackView.distribution = .fillEqually

  }
  
  fileprivate func setupImageIndexObserver() {
    cardViewModel.imageIndexObserver = { [weak self] (idx, image) in
      self?.imageView.image = image
      
      self?.barStackView.arrangedSubviews.forEach({ (v) in
        v.backgroundColor = self?.barDeselectedColor
      })
      self?.barStackView.arrangedSubviews[idx].backgroundColor = .white
    }
  }
  
  override func layoutSubviews() {
    //in here you know what your CardView frame will be
    gradientLayer.frame = self.frame
  }
  
  @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
    switch gesture.state {
    case .began:
      superview?.subviews.forEach({ (subview) in
        subview.layer.removeAllAnimations()
      })
    case .changed:
      handleChanged(gesture)
    case .ended:
      handleEnded(gesture)
    default:
      ()
    }
  }
  
  //var imageIndex = 0
  fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
  
  @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
    let tapLocation = gesture.location(in: nil)
    let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
    if shouldAdvanceNextPhoto {
      cardViewModel.advanceToNextPhoto()
    } else {
      cardViewModel.goToPreviousPhoto()
    }
    
    
    //    if shouldAdvanceNextPhoto {
//      imageIndex = min(imageIndex + 1, cardViewModel.imageNames.count - 1)
//    } else {
//      imageIndex = max(0, imageIndex - 1)
//    }
//    let imageName = cardViewModel.imageNames[imageIndex]
//    imageView.image = UIImage(named: imageName)
//    barStackView.arrangedSubviews.forEach { (v) in
//      v.backgroundColor = barDeselectedColor
//    }
//    barStackView.arrangedSubviews[imageIndex].backgroundColor = .white
  }
  
  fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
    
    let translation = gesture.translation(in: nil)
    
    //rotation
    let degrees: CGFloat = translation.x / 20
    let angle = degrees * .pi / 180
    
    let rotationTransformation = CGAffineTransform(rotationAngle: angle)
    self.transform = rotationTransformation.translatedBy(x: translation.x, y: translation.y)
    
    //self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
  }
  
  fileprivate func handleEnded(_ gesture: UIPanGestureRecognizer) {
    let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
    let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
    
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
      if shouldDismissCard {
        self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
//        self.transform = offScreenTransform
      } else {
        self.transform = .identity
      }
    }) { (_) in
      self.transform = .identity
      if shouldDismissCard {
        self.removeFromSuperview()
      }
      //self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
    }
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
