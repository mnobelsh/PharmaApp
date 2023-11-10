//
//  LoadingController.swift
//  PharmaApp
//
//  Created by Muhammad Nobel Shidqi on 10/11/23.
//

import UIKit

class LoadingController: UIViewController {
    var loadingActivityIndicator: UIActivityIndicatorView = {
      let indicator = UIActivityIndicatorView()
      indicator.style = .large
      indicator.color = .accent
      indicator.startAnimating()
      indicator.autoresizingMask = [
          .flexibleLeftMargin, .flexibleRightMargin,
          .flexibleTopMargin, .flexibleBottomMargin
      ]
      return indicator
    }()

    override func viewDidLoad() {
      view.backgroundColor = UIColor.clear
      loadingActivityIndicator.center = CGPoint(
          x: view.bounds.midX,
          y: view.bounds.midY
      )
      view.addSubview(loadingActivityIndicator)
    }
}
