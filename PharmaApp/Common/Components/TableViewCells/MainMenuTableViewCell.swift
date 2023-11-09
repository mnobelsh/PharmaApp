//
//  MainMenuTableViewCell.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

enum MainMenuItem: CaseIterable {
  case schedule, specialTreatment, tracking
  
  var title: String {
    switch self {
    case .schedule: return "Solusi, Kesehatan Anda"
    case .specialTreatment: return "Layanan Khusus"
    case .tracking: return "Track Pemeriksaan"
    }
  }
  
  var description: String {
    switch self {
    case .schedule: return "Update informasi seputar kesehatan semua bisa disini !"
    case .specialTreatment: return "Tes Covid 19, Cegah Corona Sedini Mungkin"
    case .tracking: return "Kamu dapat mengecek progress pemeriksaanmu disini"
    }
  }
  
  var actionTitle: String {
    switch self {
    case .schedule: return "Selengkapnya"
    case .specialTreatment: return "Daftar Tes"
    case .tracking: return "Track"
    }
  }
  
  var image: UIImage {
    switch self {
    case .schedule: return .schedule
    case .specialTreatment: return .medication
    case .tracking: return .tracking
    }
  }
}

class MainMenuTableViewCell: UITableViewCell {
  
  private var index: Int?
  
  private var backgroundImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  lazy var titleLabel: Label = Label(font: .gilroy(weight: .semibold, size: 18))
  lazy var descriptionLabel: Label = Label(font: .gilroy(weight: .regular, size: 14), color: .secondaryGrey)
  var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  var itemImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  lazy var actionButton: RoundedFilledButton = RoundedFilledButton(title: nil)
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [titleLabel,descriptionLabel,actionButton])
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.alignment = .leading
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  
  private lazy var actionButtonWidthConstraint: NSLayoutConstraint = actionButton.widthAnchor.constraint(equalToConstant: 100)

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    backgroundColor = .clear
    stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    descriptionLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    contentView.addSubview(containerView)
    containerView.addSubview(backgroundImageView)
    containerView.addSubview(stackView)
    containerView.addSubview(itemImageView)
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
      containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      
      backgroundImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
      backgroundImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      backgroundImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      backgroundImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
      
      actionButton.heightAnchor.constraint(equalToConstant: 32),
      actionButtonWidthConstraint,
      
      itemImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 120),
      itemImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 120)
    ])
    stackView.setCustomSpacing(12, after: descriptionLabel)
    actionButton.titleLabel?.font = .gilroy(weight: .bold, size: 14)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    containerView.rounded(radius: 20)
    containerView.dropShadow()
    var buttonPadding: CGFloat = 0
    if index == 0 {
      buttonPadding = 34
      containerView.dropShadow(offset: CGSize(width: 0, height: 7), radius: 10, opacity: 0.2)
    } else {
      containerView.dropShadow()
    }
    actionButtonWidthConstraint.constant = actionButton.intrinsicContentSize.width + buttonPadding
  }
  
  func setCell(item: MainMenuItem, index: Int) {
    self.index = index
    titleLabel.text = item.title
    descriptionLabel.text = item.description
    itemImageView.image = item.image
    actionButton.setTitle(item.actionTitle, for: .normal)
    if index == 0 {
      actionButton.setTitleColor(.white, for: .normal)
      actionButton.backgroundColor = .accent
      backgroundImageView.image = .mainMenuItemBackground
    } else {
      actionButton.setTitleColor(.accent, for: .normal)
      actionButton.backgroundColor = .clear
      backgroundImageView.image = nil
    }
  }
  
}

class LeftMainMenuTableViewCell: MainMenuTableViewCell {
  
  static var reuseIdentifier: String { String(describing: self) }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
      stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
      stackView.trailingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: -5),
      stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
      
      itemImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -40),
      itemImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
      itemImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -15),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class RightMainMenuTableViewCell: MainMenuTableViewCell {
  
  static var reuseIdentifier: String { String(describing: self) }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
      stackView.leadingAnchor.constraint(greaterThanOrEqualTo: itemImageView.trailingAnchor, constant: 5),
      stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -30),
      stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15),
      
      itemImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: -30),
      itemImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
      itemImageView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -15),
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
