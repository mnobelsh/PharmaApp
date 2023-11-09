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
  
  private var mainMenuItems: [MainMenuItem] = MainMenuItem.allCases
  
  // SUBVIEWS
  private lazy var tableView: HomeTableView = HomeTableView(frame: view.frame)
  
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
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.launchPadController!.topPadding),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    tableView.dataSource = self
    tableView.delegate = self
  }
  
  func bindViewModel() {
  }
    
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return mainMenuItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let index = indexPath.row
    let item = mainMenuItems[index]
    if index == 0 || index%2 != 0 {
      guard let cell: LeftMainMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: LeftMainMenuTableViewCell.reuseIdentifier, for: indexPath) as? LeftMainMenuTableViewCell else { return UITableViewCell() }
      cell.setCell(item: item, index: index)
      return cell
    }
    guard let cell: RightMainMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: RightMainMenuTableViewCell.reuseIdentifier, for: indexPath) as? RightMainMenuTableViewCell else { return UITableViewCell() }
    cell.setCell(item: item, index: index)
    return cell
  }
  
  
}
