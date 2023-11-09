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
  
  // SUBVIEWS
  private lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView(frame: view.frame)
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  private lazy var profileContainerView: ProfileContainerView = ProfileContainerView()
  
  init(viewModel: AccountViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profileContainerView.inputFormView.delegate = self
    view.backgroundColor = .greyscale
    view.addSubview(scrollView)
    scrollView.addSubview(profileContainerView)
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.topAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      
      profileContainerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: (UIApplication.keyWindow?.safeAreaInsets.top ?? 0) + 130),
      profileContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
      profileContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
      profileContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -32),
    ])
  }

}

extension ProfileViewController: InputFormViewDelegate {
  
  func inputFormField(_ inputFormView: InputFormView, didBeginEditing textFieldView: TextFieldView, forItem item: InputFormItem) {
    
  }
  
  func inputFormField(_ inputFormView: InputFormView, didEndEditing textFieldView: TextFieldView, forItem item: InputFormItem) {
    
  }
  
}
