//
//  QuestionsDataSingleton.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 30.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//


import Foundation
// dient zum Teilen der Fragen zwischen Controllers
class QuestionsDataSingleton  {
 
    static let sharedInstance = QuestionsDataSingleton()

    var sharedFilteredQuestions:[QuestionViewModel] = []
    
    var sharedQuestions:[QuestionViewModel] = []
    
    var loadedData : Int?
    
     
}

