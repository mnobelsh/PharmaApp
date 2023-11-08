//
//  NavigationBar.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//

import UIKit

protocol NavigationBarDelegate: AnyObject {
  func navigationBar(_ navigationBar: NavigationBar, didTapMenu menuButton: UIButton)
  func navigationBar(_ navigationBar: NavigationBar, didTapCart cartButton: UIButton)
  func navigationBar(_ navigationBar: NavigationBar, didTapNotification notificationButton: UIButton)
}

extension NavigationBarDelegate {
  func navigationBar(_ navigationBar: NavigationBar, didTapMenu menuButton: UIButton) {}
  func navigationBar(_ navigationBar: NavigationBar, didTapCart cartButton: UIButton) {}
  func navigationBar(_ navigationBar: NavigationBar, didTapNotification notificationButton: UIButton) {}
}

final class NavigationBar: UIView {
  
  weak var delegate: NavigationBarDelegate?
  
  // SUBVIEWS
  private lazy var menuButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 0
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(.dashIcon, for: .normal)
    button.addTarget(self, action: #selector(didTapNavigationButton(_:)), for: .touchUpInside)
    return button
  }()
  private lazy var cartButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 1
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(.cartIcon, for: .normal)
    button.addTarget(self, action: #selector(didTapNavigationButton(_:)), for: .touchUpInside)
    return button
  }()
  private lazy var notificationButton: UIButton = {
    let button = UIButton(type: .system)
    button.tag = 2
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(.notificationIcon, for: .normal)
    button.addTarget(self, action: #selector(didTapNavigationButton(_:)), for: .touchUpInside)
    return button
  }()
  private lazy var rightStackView: UIStackView = {
    let stackView: UIStackView = UIStackView(
      arrangedSubviews: [cartButton, notificationButton]
    )
    stackView.axis = .horizontal
    stackView.spacing = 30
    return stackView
  }()
  private lazy var mainStackView: UIStackView = {
    let stackView: UIStackView = UIStackView(
      arrangedSubviews: [menuButton, rightStackView]
    )
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    return stackView
  }()
  
  private var topPadding: CGFloat = 0
  
  init() {
    super.init(frame: CGRect(x: 0, y: 0, width: UIApplication.keyWindow?.frame.width ?? 0, height: 50))
    topPadding = UIApplication.keyWindow?.safeAreaInsets.top ?? 0
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

private extension NavigationBar {
  
  func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    addSubview(mainStackView)
    
    NSLayoutConstraint.activate([
      menuButton.widthAnchor.constraint(equalToConstant: 22),
      menuButton.heightAnchor.constraint(equalToConstant: 22),
      cartButton.widthAnchor.constraint(equalToConstant: 22),
      cartButton.heightAnchor.constraint(equalToConstant: 22),
      notificationButton.widthAnchor.constraint(equalToConstant: 22),
      notificationButton.heightAnchor.constraint(equalToConstant: 22),
      
      mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: topPadding + 10),
      mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    ])
  }
  
  @objc func didTapNavigationButton(_ sender: UIButton) {
    switch sender.tag {
    case 0:
      delegate?.navigationBar(self, didTapMenu: menuButton)
    case 1:
      delegate?.navigationBar(self, didTapCart: cartButton)
    case 2:
      delegate?.navigationBar(self, didTapNotification: notificationButton)
    default: break
    }
  }
  
}
