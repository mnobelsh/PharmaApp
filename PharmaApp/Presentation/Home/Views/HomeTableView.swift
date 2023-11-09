//
//  HomeTableView.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

final class HomeTableView: UITableView {

  init(frame: CGRect) {
    super.init(frame: frame, style: .plain)
    self.backgroundColor = .clear
    self.separatorStyle = .none
    self.estimatedRowHeight = 50
    self.rowHeight = UITableView.automaticDimension
    self.contentInsetAdjustmentBehavior = .never
    self.showsVerticalScrollIndicator = true
    self.showsHorizontalScrollIndicator = false
    self.bounces = true
    self.translatesAutoresizingMaskIntoConstraints = false
    registerCells()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

private extension HomeTableView {
  
  func registerCells() {
    register(RightMainMenuTableViewCell.self, forCellReuseIdentifier: RightMainMenuTableViewCell.reuseIdentifier)
    register(LeftMainMenuTableViewCell.self, forCellReuseIdentifier: LeftMainMenuTableViewCell.reuseIdentifier)
    register(HorizontalScrollTableViewCell.self, forCellReuseIdentifier: HorizontalScrollTableViewCell.reuseIdentifier)
    register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.reuseIdentifier)
  }
  
}
