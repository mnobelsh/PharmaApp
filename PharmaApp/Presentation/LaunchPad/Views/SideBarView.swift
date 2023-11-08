//
//  SideBarView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//

import UIKit

protocol SideBarViewDelegate: AnyObject {
  func sideBarViewDidTapMyProfile(_ sideBarView: SideBarView)
  func sideBarViewDidTapSetting(_ sideBarView: SideBarView)
  func sideBarViewDidTapLogout(_ sideBarView: SideBarView)
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
  private lazy var accountInfoView = AccountInfoView()
  private lazy var myProfileItemView: MenuItemView = MenuItemView(title: "Profile Saya")
  private lazy var settingItemView: MenuItemView = MenuItemView(title: "Pengaturan")
  private lazy var logoutButton: RoundedFilledButton = {
    let button = RoundedFilledButton(defaultBackgroundColor: .primaryRed)
    button.setTitle("Logout", for: .normal)
    return button
  }()
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [accountInfoView, myProfileItemView, settingItemView])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.spacing = 32
    stackView.alignment = .fill
    return stackView
  }()
  private lazy var closeButton: ImageButton = {
    let button = ImageButton(image: .closeIcon)
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
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  func animateShowContentView() {
    contentViewTrailingConstraint.constant = 0
    isExpanded = true
    draggingIsEnabled = true
    UIView.animate(withDuration: 0.15) {
      self.layoutIfNeeded()
    }
    toggleContentViewHidden()
  }
  
  func animateHideContentView() {
    contentViewTrailingConstraint.constant = contentViewWidth
    isExpanded = false
    draggingIsEnabled = false
    UIView.animate(withDuration: 0.15) {
      self.layoutIfNeeded()
    }
    toggleContentViewHidden()
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
    contentView.addSubview(stackView)
    contentView.addSubview(logoutButton)
    addSubview(closeButton)
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(equalTo: topAnchor),
      contentView.widthAnchor.constraint(equalToConstant: contentViewWidth),
      contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
      contentViewTrailingConstraint,
      
      stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: frame.height/6),
      stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
      
      logoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
      logoutButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
      logoutButton.heightAnchor.constraint(equalToConstant: 40),
      logoutButton.widthAnchor.constraint(equalToConstant: 140),
      
      closeButton.widthAnchor.constraint(equalToConstant: 30),
      closeButton.heightAnchor.constraint(equalToConstant: 30),
      closeButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
      closeButton.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -12),
    ])
    contentViewTrailingConstraint.constant = contentViewWidth
    stackView.setCustomSpacing(20, after: myProfileItemView)
    logoutButton.layoutIfNeeded()
  }
  
  func setupGestures() {
    let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(onContentViewDidDrag(_:)))
    contentView.addGestureRecognizer(dragGesture)
    let myProfileGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuItem(_:)))
    myProfileItemView.addGestureRecognizer(myProfileGesture)
    let settingGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenuItem(_:)))
    settingItemView.addGestureRecognizer(settingGesture)
    logoutButton.addTarget(self, action: #selector(didTapLogout(_:)), for: .touchUpInside)
  }
  
  func toggleContentViewHidden() {
    UIView.animate(withDuration: 0.5) {
      self.alpha = self.isExpanded ? 1 : 0
    } completion: { _ in
      self.isHidden = !self.isExpanded
    }
  }
  
  @objc
  func didTapMenuItem(_ sender: UITapGestureRecognizer) {
    switch sender.view {
    case myProfileItemView: delegate?.sideBarViewDidTapMyProfile(self)
    case settingItemView: delegate?.sideBarViewDidTapSetting(self)
    default: break
    }
  }
  
  @objc
  func didTapLogout(_ sender: UIButton) {
    delegate?.sideBarViewDidTapLogout(self)
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

// MARK: - Menu Item View
private class MenuItemView: UIStackView {
  
  lazy var profileImageView: UIImageView = {
    let imageView = UIImageView(
      image: UIImage(systemName: "chevron.right")?
        .withTintColor(.secondaryGrey, renderingMode: .alwaysOriginal)
    )
    imageView.clipsToBounds = true
    return imageView
  }()
  lazy var itemLabel: UILabel = Label(font: .gilroy(weight: .semibold, size: 16), color: .secondaryGrey)

  init(title: String? = nil) {
    super.init(frame: .zero)
    setTitle(text: title)
    addArrangedSubview(itemLabel)
    addArrangedSubview(profileImageView)
    axis = .horizontal
    spacing = 50
    distribution = .equalSpacing
    alignment = .fill
    isUserInteractionEnabled = true
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setTitle(text: String?) {
    itemLabel.text = text
  }
  
}


// MARK: - Account Info View
private class AccountInfoView: UIStackView {
  
  lazy var profileImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    return imageView
  }()
  lazy var nameLabel: UILabel = Label()
  lazy var membershipLabel: UILabel = Label(text: "Membership BBLK", color: .secondaryGrey)
  private lazy var nameStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [nameLabel,membershipLabel])
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()

  init() {
    super.init(frame: .zero)
    addArrangedSubview(profileImageView)
    addArrangedSubview(nameStackView)
    axis = .horizontal
    spacing = 20
    distribution = .fill
    alignment = .center
    profileImageView.backgroundColor = .secondaryGrey
    NSLayoutConstraint.activate([
      profileImageView.widthAnchor.constraint(equalToConstant: 50),
      profileImageView.heightAnchor.constraint(equalToConstant: 50),
    ])
    nameLabel.setAttributedText(text: "Angga Praja", defaultAttributes: [
      .foregroundColor: UIColor.accent,
      .font: UIFont.gilroy(weight: .regular, size: 18)
    ], attributedText: "Angga", secondAttributes: [
      .foregroundColor: UIColor.accent,
      .font: UIFont.gilroy(weight: .bold, size: 18)
    ])
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    profileImageView.rounded()
  }
  
}
