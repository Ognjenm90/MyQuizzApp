//
//  UIView+Xib.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.06.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//


import UIKit

extension UIView {
    class func instantiateFromNib<T: UIView>(_ viewType: T.Type) -> T {
        let url = URL(string: NSStringFromClass(viewType))
        return Bundle.main.loadNibNamed((url?.pathExtension)!, owner: nil, options: nil)!.first as! T
    }
    
    class func instantiateFromNib() -> Self {
        return instantiateFromNib(self)
    }
}
