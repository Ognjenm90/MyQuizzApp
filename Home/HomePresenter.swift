//
//  HomePresenter.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 01.07.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation

protocol HomeViewPresenter: class {
    init(view: HomeView)
}

protocol HomeView: class {
    // TODO: Declare view methods
}

class HomePresenter: HomeViewPresenter {
    
    static func config(withHomeViewController viewController: HomeViewController) {
        let presenter = HomePresenter(view: viewController)
        viewController.presenter = presenter
    }
    
    let view: HomeView
    
    required init(view: HomeView) {
        self.view = view
    }
}
