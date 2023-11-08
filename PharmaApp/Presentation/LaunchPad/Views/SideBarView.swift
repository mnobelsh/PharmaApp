//
//  SideBarView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

protocol SideBarViewDelegate: AnyObject {
  
}

final class SideBarView: UIView {
  
  weak var delegate: SideBarViewDelegate?
  
  override var isHidden: Bool {
    didSet {
      if isHidden {
        contentViewTrailingConstraint.constant = contentViewWidth
        isExpanded = false
        draggingIsEnabled = false
      } else {
        contentViewTrailingConstraint.constant = 0
        isExpanded = true
        draggingIsEnabled = true
      }
      UIView.animate(withDuration: 0.25) {
        self.alpha = self.isHidden ? 0 : 1
        self.layoutIfNeeded()
      }
    }
  }
  
  private var draggingIsEnabled: Bool = false
  private var isExpanded: Bool = false
  private lazy var widthThreshold: CGFloat = (frame.width / 2) + 60
  private lazy var contentViewWidth: CGFloat = frame.width - 60
  private lazy var contentViewTrailingConstraint: NSLayoutConstraint = contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
  
  // SUBVIEWS
  lazy var contentView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = true
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  private lazy var closeButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 0
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(.closeIcon, for: .normal)
    button.addTarget(self, action: #selector(didTapCloseButton(_:)), for: .touchUpInside)
    return button
  }()
  
  init() {
    super.init(frame: UIApplication.keyWindow?.frame ?? UIScreen.main.bounds)
    setupView()
    setupGestures()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

private extension SideBarView {
  
  func setupView() {
    contentViewWidth = frame.width - 60
    widthThreshold = (frame.width / 2) + 60
    isUserInteractionEnabled = true
    backgroundColor = .accent.withAlphaComponent(0.8)
    translatesAutoresizingMaskIntoConstraints = false
    
    addSubview(contentView)
    addSubview(closeButton)
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.widthAnchor.constraint(equalToConstant: contentViewWidth),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentViewTrailingConstraint,
      
      closeButton.widthAnchor.constraint(equalToConstant: 30),
      closeButton.heightAnchor.constraint(equalToConstant: 30),
      closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -12),
    ])
    contentViewTrailingConstraint.constant = contentViewWidth
  }
  
  func setupGestures() {
    let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(onContentViewDidDrag(_:)))
    contentView.addGestureRecognizer(dragGesture)
  }
  
  func toggleContentViewHidden() {
    UIView.animate(withDuration: 0.5) {
      self.alpha = self.isExpanded ? 1 : 0
    } completion: { _ in
      self.isHidden = !self.isExpanded
    }
  }
  
  func animateShowContentView() {
    contentViewTrailingConstraint.constant = 0
    isExpanded = true
    UIView.animate(withDuration: 0.15) {
      self.layoutIfNeeded()
    }
    toggleContentViewHidden()
  }
  
  func animateHideContentView() {
    contentViewTrailingConstraint.constant = contentViewWidth
    isExpanded = false
    UIView.animate(withDuration: 0.15) {
      self.layoutIfNeeded()
    }
    toggleContentViewHidden()
  }
  
  @objc
  func didTapCloseButton(_ sender: UIButton) {
    animateHideContentView()
  }
  
  @objc
  func onContentViewDidDrag(_ sender: UIPanGestureRecognizer) {
    let position = sender.location(in: self).x
    let velocity = sender.velocity(in: self).x
    switch sender.state {
    case .began:
      if velocity < 0, isExpanded {
        sender.state = .cancelled
      }
      if velocity < 0, !isExpanded {
        draggingIsEnabled = true
      } else if velocity > 0, isExpanded {
        draggingIsEnabled = true
      }
    case .changed:
      if draggingIsEnabled {
        if abs(position) < 60 {
          draggingIsEnabled = false
          sender.state = .ended
          return
        }
        contentViewTrailingConstraint.constant = abs(position) - 60
        UIView.animate(withDuration: 0.15) {
          self.layoutIfNeeded()
        }
      }
    case .ended:
      draggingIsEnabled = false
      position < widthThreshold ? animateShowContentView() : animateHideContentView()
    default: break
    }
  }
  
}
