//
//  DificultyViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 28.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import UIKit

class DificcultyViewController : UIViewController{
    
    @IBOutlet var easyButton: UIButton!
    @IBOutlet var mediumButton: UIButton!
    @IBOutlet var hardButton: UIButton!
    var name:String = ""
    var clientPresenter: LobbyPresenter!
    var filteredQuestions : [QuestionViewModel] = []
    var fQuestions: [QuestionViewModel] = []
    var categoryArray:[String] = []
    var dificultyArray:[String] = []
    var gameType:String = ""
    var totalFilteredQuestions:[QuestionViewModel] = []
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        easyButton.clipsToBounds = true
        easyButton.layer.cornerRadius = 10
        easyButton.layer.borderColor = UIColor.yellow.cgColor
        easyButton.layer.borderWidth = 2.0
        easyButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        mediumButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        mediumButton.layer.cornerRadius = 10
        mediumButton.layer.borderColor = UIColor.yellow.cgColor
        mediumButton.layer.borderWidth = 2.0
        mediumButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        hardButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        hardButton.layer.cornerRadius = 10
        hardButton.layer.borderColor = UIColor.yellow.cgColor
        hardButton.layer.borderWidth = 2.0
        hardButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "saveButtonSeque") {
            let vc = segue.destination as! StartViewController
            
            vc.name = name
            
            if(dificultyArray.count == 0){
                for q in QuestionsDataSingleton.sharedInstance.sharedQuestions{
                          for c in categoryArray{
                              if q.category == c{
                                  if(!vc.filteredQuestions.contains(q)){
                                      vc.filteredQuestions.append(q)}
                              }
                          }
                      }
                
            }else{
                vc.filteredQuestions = totalFilteredQuestions
            }
            
            vc.gameType = gameType
        }
    }
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        
        self.performSegue(withIdentifier:"saveButtonSeque", sender: EnumPlayerType.host);
    }
    
    //Aktion wenn ein Button für Schwierigkeitsgrad geklickt wird
    @objc func buttonAction(sender: UIButton) {
        if sender == self.easyButton {
            if(self.easyButton.backgroundColor !== UIColor.red){
                dificultyArray.append("easy")
                self.easyButton.backgroundColor = UIColor.red
              }
            else{
                self.easyButton.backgroundColor = UIColor.systemTeal
                while dificultyArray.contains("easy") {
                    if let itemToRemoveIndex = dificultyArray.index(of: "easy") {
                        dificultyArray.remove(at: itemToRemoveIndex)
                    }}}}
        else if sender == self.mediumButton {
            if(self.mediumButton.backgroundColor !== UIColor.red){
                dificultyArray.append("medium")
                self.mediumButton.backgroundColor = UIColor.red
          
            }
            else{
                self.mediumButton.backgroundColor = UIColor.systemTeal
                while dificultyArray.contains("medium") {
                    if let itemToRemoveIndex = dificultyArray.index(of: "medium") {
                        dificultyArray.remove(at: itemToRemoveIndex)
                    }}}}
        else if sender == self.hardButton {
            
            if(self.hardButton.backgroundColor !== UIColor.red){
                dificultyArray.append("hard")
                self.hardButton.backgroundColor = UIColor.red
            }
            else{
                self.hardButton.backgroundColor = UIColor.systemTeal
                while dificultyArray.contains("hard") {
                    if let itemToRemoveIndex = dificultyArray.index(of: "hard") {
                        dificultyArray.remove(at: itemToRemoveIndex)
                    }}}}
        
        //DAS FILTRIEREN DER FRAGEN
        
        for q in QuestionsDataSingleton.sharedInstance.sharedQuestions{
            for c in categoryArray{
                if q.category == c{
                    if(!fQuestions.contains(q)){
                        fQuestions.append(q)}
                }
            }
        }
        totalFilteredQuestions = fQuestions.filter({ dificultyArray.contains($0.difficulty) })
    }
    
}

