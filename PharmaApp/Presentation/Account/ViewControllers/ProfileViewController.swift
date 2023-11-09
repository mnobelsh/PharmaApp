//
//  ProfileViewController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 09/11/23.
//

import UIKit
import Combine

final class ProfileViewController: UIViewController {
  
  private(set) var viewModel: AccountViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  init(viewModel: AccountViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .greyscale
  }

}
