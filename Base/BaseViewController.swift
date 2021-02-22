//
//  BaseViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.06.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import UIKit
import AMPopTip

class BaseViewController: UIViewController {
    
     var loadingView: LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadingView = LoadingView.instantiateFromNib()
    }
    
    deinit {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
    
    
    func showLoading(withView view: UIView, andTitle title: String?) {
        loadingView?.startLoadView(view, withTitle: title)
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
    }
}
