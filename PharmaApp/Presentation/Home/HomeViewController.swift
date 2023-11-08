//
//  HomeViewController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
  private(set) var viewModel: HomeViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  init(viewModel: HomeViewModel) {
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
private extension HomeViewController {
    
  func setupViewDidLoad() {
    view.backgroundColor = .white
  }
  
  func bindViewModel() {
  }
    
}
