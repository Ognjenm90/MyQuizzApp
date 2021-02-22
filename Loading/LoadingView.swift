//
//  LoadingView.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.06.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import UIKit

class LoadingView: UIView {
    
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingImage: UIImageView!

    
    func startLoadView(_ view: UIView, withTitle title: String?) {
        setupLoadingImage()
        
        loadingLabel.text = title
        
        self.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        self.center = view.center
        view.addSubview(self)
    }
    
    func stopLoadView() {
        loadingImage.stopAnimating()
    }
    
    func setupLoadingImage() {
        loadingImage.animationImages = [UIImage(named: "loading1")!, UIImage(named: "loading2")!, UIImage(named: "loading3")!]
        loadingImage.animationDuration = 1.1
        loadingImage.startAnimating()
    }
}
