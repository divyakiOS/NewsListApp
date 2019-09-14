//
//  Utility.swift
//  NewsApp
//
//  Created by RAC INFRA RENTAL LLP on 14/09/19.
//  Copyright © 2019 RAC INFRA RENTAL LLP. All rights reserved.
//


import UIKit

class Utility: NSObject {
    
    static let shared = Utility()
    
    private var container: UIView = UIView()
    private var loadingView: UIView = UIView()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func  showActivityIndicator() {
        
        let viewController = (UIApplication.shared.keyWindow?.rootViewController)! as UIViewController
        let uiView = viewController.view
        container.frame = (uiView?.frame)!
        container.center = (uiView?.center)!
        loadingView.frame = (uiView?.frame)!
        loadingView.backgroundColor = .black
        loadingView.center = (uiView?.center)!
        loadingView.alpha = 0.3
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        container.addSubview(loadingView)
        
        let win : UIWindow = ((UIApplication.shared.delegate?.window)!)!
        win.addSubview(container)
        win.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.container.removeFromSuperview()
        }
    }
    
}
