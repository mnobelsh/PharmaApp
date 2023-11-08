//
//  LaunchScreenViewController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 07/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit
import Combine

final class LaunchScreenViewController: UIViewController {
    
  private(set) var viewModel: LaunchScreenViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  init(viewModel: LaunchScreenViewModel) {
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
private extension LaunchScreenViewController {
    
  func setupViewDidLoad() {
    view.backgroundColor = .systemRed
  }
  
  func bindViewModel() {
  }
    
}
