//
//  Presenter.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 24.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation

import Foundation

protocol Presenter {
    
    associatedtype Entity
    associatedtype ViewModel
    
    static func present(entity: Entity) -> ViewModel
}
