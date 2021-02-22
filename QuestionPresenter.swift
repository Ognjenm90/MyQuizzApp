//
//  QuestionPresenter.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 24.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation

//Die Klasse dient dazu, das JSON-model zu Model (QuestionViewModel) zum Anzeigen zu übersetzen
struct QuestionPresenter  {
    
    typealias Entity = QuestionJSON
    typealias ViewModel = QuestionViewModel
    
    
    
    static func present(entity: QuestionJSON) -> QuestionViewModel {
        if(entity.type == "multiple"){
            
         //Die folgende Zeilen sind dazu, dass immer im anderen Knopf richtiger Antwort ist
            
        let number = Int.random(in: 0 ..< 3)
  
        if(number == 0)
        {
        return QuestionViewModel(
            category: entity.category, type: entity.type, questionText: entity.question, options: [entity.correct_answer,entity.incorrect_answers[0],entity.incorrect_answers[1],entity.incorrect_answers[2]], incorrect_answer: -1, correct_answer: 0, isAnswered: false,difficulty: entity.difficulty,selected: false
        )
    }else if(number == 1)
        {
        return QuestionViewModel(
            category: entity.category, type: entity.type, questionText: entity.question, options: [entity.incorrect_answers[0],entity.correct_answer,entity.incorrect_answers[1],entity.incorrect_answers[2]], incorrect_answer: -1, correct_answer: 1, isAnswered: false,difficulty: entity.difficulty,selected: false
        )
    }
        else if(number == 2)
            {
            return QuestionViewModel(
                category: entity.category, type: entity.type, questionText: entity.question, options: [entity.incorrect_answers[0],entity.incorrect_answers[1],entity.correct_answer,entity.incorrect_answers[2]], incorrect_answer: -1, correct_answer: 2, isAnswered: false,difficulty: entity.difficulty,selected: false
            )
        }
        else if(number == 3)
            {
                         return QuestionViewModel(
                  category: entity.category, type: entity.type, questionText: entity.question, options: [entity.incorrect_answers[0],entity.incorrect_answers[1],entity.incorrect_answers[2],entity.correct_answer], incorrect_answer: -1, correct_answer: 3, isAnswered: false,difficulty: entity.difficulty,selected: false
              )

        }
      
        }else
        {
            let number = Int.random(in: 0 ..< 1)
            
                  if(number == 0)
                  {
                  return QuestionViewModel(
                      category: entity.category, type: entity.type, questionText: entity.question, options: [entity.correct_answer,entity.incorrect_answers[0]], incorrect_answer: -1, correct_answer: 0, isAnswered: false,difficulty: entity.difficulty,selected: false
                  )
              }
                  else if(number == 1)
                  {
                  return QuestionViewModel(
                      category: entity.category, type: entity.type, questionText: entity.question, options: [entity.incorrect_answers[0],entity.correct_answer], incorrect_answer: -1, correct_answer: 1, isAnswered: false,difficulty: entity.difficulty,selected: false
                  )
              }
                 
                
        }
 return QuestionViewModel(
     category: entity.category, type: entity.type, questionText: entity.question, options: [entity.incorrect_answers[0],entity.correct_answer], incorrect_answer: -1, correct_answer: 1, isAnswered: false,difficulty: entity.difficulty,selected: false
 )
    }
}
