//
//  AccountViewController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 08/11/23.
//  Copyright (c) 2023 All rights reserved.
//

import UIKit
import Combine
import Parchment
import BetterSegmentedControl

final class AccountViewController: PagingViewController {
    
  private(set) var viewModel: AccountViewModel!
  private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
  
  private var profileViewController: ProfileViewController!
  private var settingViewController: SettingViewController!
  private var viewControllers: [UIViewController] = []
  
  // SUBVIEWS
  private lazy var segmentedControl: BetterSegmentedControl = {
    let segmentedControl = BetterSegmentedControl(
      frame: CGRect(x: 0, y: 0, width: 260.0, height: 40.0),
      segments:
        LabelSegment.segments(
          withTitles: ["Profile Saya", "Pengaturan"],
          normalFont: .gilroy(weight: .regular, size: 16), 
          normalTextColor: .accent,
          selectedFont: .gilroy(weight: .semibold, size: 16),
          selectedTextColor: .accent
        ),
      options: [
        .backgroundColor(.white),
        .indicatorViewBackgroundColor(.secondaryGreen),
        .cornerRadius(20.0),
        .animationSpringDamping(1.0)]
    )
    segmentedControl.addTarget(self, action: #selector(onSegmentedControlValueChanged(_:)), for: .valueChanged)
    segmentedControl.translatesAutoresizingMaskIntoConstraints = false
    return segmentedControl
  }()
  
  init(selectedIndex: Int = 0, viewModel: AccountViewModel) {
    self.viewModel = viewModel
    self.profileViewController = ProfileViewController(viewModel: viewModel)
    self.settingViewController = SettingViewController(viewModel: viewModel)
    self.viewControllers = [profileViewController,settingViewController]
    super.init()
    self.dataSource = self
    self.delegate = self
    self.segmentedControl.setIndex(selectedIndex)
    self.select(index: selectedIndex, animated: false)
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
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    segmentedControl.dropShadow()
  }
    
}

// MARK: Private Functions
private extension AccountViewController {
    
  func setupViewDidLoad() {
    view.backgroundColor = .greyscale
    view.addSubview(segmentedControl)
    NSLayoutConstraint.activate([
      segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: self.launchPadController!.topPadding + 30),
      segmentedControl.heightAnchor.constraint(equalToConstant: 40),
      segmentedControl.widthAnchor.constraint(equalToConstant: 260),
      segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSelectSideBarMenuNotification(_:)), name: .didSelectSideBarMenu, object: nil)
  }
  
  func bindViewModel() {
  }
  
  @objc
  func onSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
    self.select(index: sender.index, animated: true)
  }
  
  @objc
  func didReceiveSelectSideBarMenuNotification(_ notification: NSNotification) {
    guard let info = notification.userInfo as? [String: Int], 
         let selectedIndex = info["index"]
    else { return }
    self.select(index: selectedIndex, animated: true)
  }
    
}

extension AccountViewController: PagingViewControllerDataSource, PagingViewControllerDelegate {
  
  func pagingViewController(_: Parchment.PagingViewController, pagingItemAt index: Int) -> Parchment.PagingItem {
    return PagingIndexItem(index: index, title: "")
  }
  
  func pagingViewController(_: Parchment.PagingViewController, viewControllerAt index: Int) -> UIViewController {
    return viewControllers[index]
  }
  
  func numberOfViewControllers(in pagingViewController: Parchment.PagingViewController) -> Int {
    return viewControllers.count
  }
  
  func pagingViewController(_ pagingViewController: PagingViewController, didScrollToItem pagingItem: PagingItem, startingViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
    guard transitionSuccessful else { return }
    let index = Int(viewControllers.firstIndex(of: destinationViewController) ?? 0)
    segmentedControl.setIndex(index, animated: true, shouldSendValueChangedEvent: false)
  }
  
}
