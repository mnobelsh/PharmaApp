//
//  RegisterViewController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit
import Combine

final class RegisterViewController: UIViewController {
    
  private(set) var viewModel: RegisterViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  // SUBVIEWS
  private lazy var inputFormView: InputFormView = InputFormView(items: [.firstName,.lastName,.id,.email,.phoneNumber,.password,.confirmPassword])
  private lazy var welcomeContainerView: WelcomeContainerView = WelcomeContainerView(pageType: .register)
  
  init(viewModel: RegisterViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewDidLoad()
    viewModel.viewDidLoad()
    bindViewModel()
  }
    
}

// MARK: Private Functions
private extension RegisterViewController {
    
  func setupViewDidLoad() {
    view.backgroundColor = .white
    
    welcomeContainerView.addToView(self.view)
    NSLayoutConstraint.activate([
      welcomeContainerView.topAnchor.constraint(equalTo: view.topAnchor),
      welcomeContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      welcomeContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      welcomeContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    ])
    welcomeContainerView.setInputFormView(inputFormView)
    welcomeContainerView.containerDelegate = self
  }
  
  func bindViewModel() {
  }
    
}

extension RegisterViewController: WelcomeContainerViewDelegate {
  
  func welcomeContainerView(_ containerView: WelcomeContainerView, didTapActionButton button: RoundedFilledButton) {

  }

  func welcomeContainerView(_ containerView: WelcomeContainerView, didTapRedirectionLabel label: UILabel, sender: UITapGestureRecognizer, willNavigateTo destination: WelcomeContainerView.PageType) {
    self.navigationController?.popViewController(animated: true)
  }

}
