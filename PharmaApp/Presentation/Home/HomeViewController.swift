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
    return HomeTableView.Section.allCases.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch HomeTableView.Section.allCases[section] {
    case .mainMenu: return mainMenuItems.count
    case .product: return 1
    case .service: return 10
    }
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let index = indexPath.row
    
    switch HomeTableView.Section.allCases[indexPath.section] {
    case .mainMenu:
      let item = mainMenuItems[index]
      if index == 0 || index%2 != 0 {
        guard let cell: LeftMainMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: LeftMainMenuTableViewCell.reuseIdentifier, for: indexPath) as? LeftMainMenuTableViewCell else { return UITableViewCell() }
        cell.setCell(item: item, index: index)
        return cell
      }
      guard let cell: RightMainMenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: RightMainMenuTableViewCell.reuseIdentifier, for: indexPath) as? RightMainMenuTableViewCell else { return UITableViewCell() }
      cell.setCell(item: item, index: index)
      return cell
    case .product:
      guard let cell: HorizontalScrollTableViewCell = tableView.dequeueReusableCell(withIdentifier: HorizontalScrollTableViewCell.reuseIdentifier, for: indexPath) as? HorizontalScrollTableViewCell else { return UITableViewCell() }
      return cell
    case .service:
      guard let cell: ServiceTableViewCell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.reuseIdentifier, for: indexPath) as? ServiceTableViewCell else { return UITableViewCell() }
      return cell
    }

  }
  
  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
  }
  
  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 40
  }
  
}
