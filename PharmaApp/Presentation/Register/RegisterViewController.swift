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
  }
  
  func bindViewModel() {
  }
    
}
