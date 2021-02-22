//
//  QuestionsDataSingleton.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation

class QuestionsDataSingleton {
    
    static let sharedInstance = QuestionsDataSingleton()
    
    
    
    var sharedQuestions:[QuestionViewModel] = []
    
    var loadedData : Int?
    
    init() {
    }
    
}
