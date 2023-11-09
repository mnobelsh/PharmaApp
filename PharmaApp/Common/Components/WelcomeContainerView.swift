//
//  WelcomeContainerView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit

protocol WelcomeContainerViewDelegate: AnyObject {
  func welcomeContainerView(_ containerView: WelcomeContainerView, didTapActionButton button: RoundedFilledButton)
  func welcomeContainerView(_ containerView: WelcomeContainerView, didTapRedirectionLabel label: UILabel, sender: UITapGestureRecognizer, willNavigateTo destination: WelcomeContainerView.PageType)
}

final class WelcomeContainerView: UIScrollView {
  
  enum PageType {
    case login, register
    
    var title: String {
      switch self {
      case .login: return "Login"
      case .register: return "Register"
      }
    }
  }
  
  weak var containerDelegate: WelcomeContainerViewDelegate?
  
  private lazy var headerView: HeaderView = HeaderView()
  private var footerView: FooterView
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [headerView, footerView])
    stackView.axis = .vertical
    stackView.spacing = 20
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private lazy var inputFormContainerView: UIView = {
    let view = UIView()
    view.isUserInteractionEnabled = true
    return view
  }()
  
  private(set) var pageType: PageType
  private(set) var inputFormView: InputFormView?
  
  init(pageType: PageType) {
    self.pageType = pageType
    self.footerView = FooterView(pageType: pageType)
    super.init(frame: .zero)
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
    translatesAutoresizingMaskIntoConstraints = false
    addSubview(stackView)
    setupFooterView()
    footerView.actionButton.addTarget(self, action: #selector(onActionButtonlDidTap(_:)), for: .touchUpInside)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setInputFormView(_ inputFormView: InputFormView) {
    self.inputFormView = inputFormView
    
    self.inputFormView?.translatesAutoresizingMaskIntoConstraints = false
    inputFormContainerView.addSubview(self.inputFormView!)
    NSLayoutConstraint.activate([
      self.inputFormView!.topAnchor.constraint(equalTo: inputFormContainerView.topAnchor),
      self.inputFormView!.leadingAnchor.constraint(equalTo: inputFormContainerView.leadingAnchor, constant: 20),
      self.inputFormView!.trailingAnchor.constraint(equalTo: inputFormContainerView.trailingAnchor, constant: -20),
      self.inputFormView!.bottomAnchor.constraint(equalTo: inputFormContainerView.bottomAnchor),
    ])
    
    stackView.insertArrangedSubview(inputFormContainerView, at: 1)
    stackView.setCustomSpacing(6, after: headerView)
    stackView.setCustomSpacing(40, after: inputFormContainerView)
  }
  
  func addToView(_ superView: UIView) {
    superView.addSubview(self)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: topAnchor, constant: 50),
      stackView.leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: superView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
    ])
  }
  
  func setupFooterView() {
    switch pageType {
    case .register:
      footerView.redirectionLabel.setAttributedText(
        text: "Sudah Punya Akun ? Login Sekarang",
        defaultAttributes: [
          .font: UIFont.gilroy(weight: .regular, size: 14),
          .foregroundColor: UIColor.secondaryGrey
        ],
        attributedText: "Login Sekarang",
        secondAttributes: [
          .font: UIFont.gilroy(weight: .semibold, size: 14),
          .foregroundColor: UIColor.accent
        ]
      )
    case .login:
      footerView.redirectionLabel.setAttributedText(
        text: "Belum Punya Akun ? Daftar Sekarang",
        defaultAttributes: [
          .font: UIFont.gilroy(weight: .regular, size: 14),
          .foregroundColor: UIColor.secondaryGrey
        ],
        attributedText: "Daftar Sekarang",
        secondAttributes: [
          .font: UIFont.gilroy(weight: .semibold, size: 14),
          .foregroundColor: UIColor.accent
        ]
      )
    }
    footerView.redirectionLabel.isUserInteractionEnabled = true
    let tapRegisterGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onRedirectionLabelDidTap(_:)))
    footerView.redirectionLabel.addGestureRecognizer(tapRegisterGesture)
  }
  
  @objc
  private func onRedirectionLabelDidTap(_ sender: UITapGestureRecognizer) {
    guard let text = footerView.redirectionLabel.text else { return }

    switch pageType {
    case .login:
      let range = (text as NSString).range(of: "Daftar Sekarang")
      guard sender.didTapAttributedTextInLabel(label: footerView.redirectionLabel, inRange: range) else { return }
      containerDelegate?.welcomeContainerView(self, didTapRedirectionLabel: footerView.redirectionLabel, sender: sender, willNavigateTo: .register)
    case .register:
      let range = (text as NSString).range(of: "Login Sekarang")
      guard sender.didTapAttributedTextInLabel(label: footerView.redirectionLabel, inRange: range) else { return }
      containerDelegate?.welcomeContainerView(self, didTapRedirectionLabel: footerView.redirectionLabel, sender: sender, willNavigateTo: .login)
    }
  }
  
  @objc
  private func onActionButtonlDidTap(_ sender: RoundedFilledButton) {
    containerDelegate?.welcomeContainerView(self, didTapActionButton: sender)

  }
  
  
}

private final class HeaderView: UIView {
  
  private lazy var titleLabel: Label = Label(font: .gilroy(weight: .semibold, size: 28))
  private lazy var descriptionLabel: Label = Label(text: "Silahkan login untuk melanjutkan", font: .gilroy(weight: .semibold, size: 14), color: .secondaryGrey)
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView(image: .welcome)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  init() {
    super.init(frame: .zero)
    addSubview(titleLabel)
    addSubview(descriptionLabel)
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
      descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
      
      imageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
      imageView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
      imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    setupLabel()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupLabel() {
    titleLabel.setAttributedText(
      text: "Hai, Selamat Datang",
      defaultAttributes: [
        .font: UIFont.gilroy(weight: .semibold, size: 28),
        .foregroundColor: UIColor.accent
      ],
      attributedText: "Selamat Datang",
      secondAttributes: [
        .font: UIFont.gilroy(weight: .bold, size: 28),
        .foregroundColor: UIColor.accent
      ]
    )
  }
  
}

private final class FooterView: UIView {
  
  lazy var actionButton: RoundedFilledButton = RoundedFilledButton(title: nil)
  lazy var redirectionLabel: Label = Label()
  lazy var copyrightLabel: Label = Label(text: "© SILK. all right reserved.", font: .gilroy(weight: .semibold, size: 12), color: .secondaryGrey)
  
  init(pageType: WelcomeContainerView.PageType) {
    super.init(frame: .zero)
    actionButton.setTitle(pageType.title, for: .normal)
    addSubview(actionButton)
    addSubview(redirectionLabel)
    addSubview(copyrightLabel)
    
    NSLayoutConstraint.activate([
      actionButton.heightAnchor.constraint(equalToConstant: 48),
      actionButton.topAnchor.constraint(equalTo: topAnchor),
      actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
      actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

      redirectionLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 30),
      redirectionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      redirectionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
      redirectionLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),

      copyrightLabel.topAnchor.constraint(equalTo: redirectionLabel.bottomAnchor, constant: 50),
      copyrightLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      copyrightLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
