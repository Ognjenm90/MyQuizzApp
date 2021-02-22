//
//  ResultViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 25.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//


import UIKit

extension ResultViewController {
    // TODO: implement view methods
}

class ResultViewController: UIViewController {
    var opponentScore: Int = 0
    var score: Int = 0
    var totalScore: Int?
    var window: UIWindow?
    var gameType:String = ""
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupViews()
      }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    //bestimmt durch das Vergelich mit dem Score des Gegners welches Komentar es sein wird
    func showRating() {
        var rating = ""
        var color = UIColor.black
        if score <= opponentScore {
            rating = "Du hast verloren!"
            color = UIColor.red
        }  else if score == opponentScore {
            rating = "Du bist gleich mit dem Gegner"
           color = UIColor.orange
        }else  {
            rating = "Du hast gewonnen!"
            color = UIColor.blue
        }
        labelRating.text = "\(rating)"
        labelRating.textColor=color
    }
  
    @objc func buttonRestartAction() {
        for q in QuestionsDataSingleton.sharedInstance.sharedQuestions{
            q.selected = false
        }
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setupViews() {
        
        //Hiew wird bestimmt (mit "if" schleife) ob das Score des Gegner angezeigt wird abhängig davon ob multi- oder singleplayer gespielt wird
        
         if(gameType == "multiplayer"){
        self.view.addSubview(labelYourScore)
        labelYourScore.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive=true
        labelYourScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelYourScore.widthAnchor.constraint(equalToConstant: 250).isActive=true
        labelYourScore.heightAnchor.constraint(equalToConstant: 80).isActive=true
        
        self.view.addSubview(labelScore)
        labelScore.topAnchor.constraint(equalTo: labelYourScore.bottomAnchor, constant: 0).isActive=true
        labelScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelScore.widthAnchor.constraint(equalToConstant: 150).isActive=true
        labelScore.heightAnchor.constraint(equalToConstant: 60).isActive=true
        labelScore.text = "\(score) / \(totalScore!)"
     
        self.view.addSubview(labelOponent)
               labelOponent.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 80).isActive=true
               labelOponent.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
               labelOponent.widthAnchor.constraint(equalToConstant: 250).isActive=true
               labelOponent.heightAnchor.constraint(equalToConstant: 80).isActive=true
        
        self.view.addSubview(labelOponentScore)
        labelOponentScore.topAnchor.constraint(equalTo: labelOponent.bottomAnchor, constant: 0).isActive=true
        labelOponentScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelOponentScore.widthAnchor.constraint(equalToConstant: 150).isActive=true
        labelOponentScore.heightAnchor.constraint(equalToConstant: 60).isActive=true
        labelOponentScore.text = "\(opponentScore) / \(totalScore!)"
        
        self.view.addSubview(labelRating)
        labelRating.topAnchor.constraint(equalTo: labelOponentScore.bottomAnchor, constant: 40).isActive=true
        labelRating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelRating.widthAnchor.constraint(equalToConstant: 150).isActive=true
        labelRating.heightAnchor.constraint(equalToConstant: 60).isActive=true
        showRating()
        
        self.view.addSubview(buttonRestart)
        buttonRestart.topAnchor.constraint(equalTo: labelRating.bottomAnchor, constant: 40).isActive=true
        buttonRestart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        buttonRestart.widthAnchor.constraint(equalToConstant: 150).isActive=true
        buttonRestart.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonRestart.addTarget(self, action: #selector(buttonRestartAction), for: .touchUpInside)}
         else{
            self.view.addSubview(labelYourScore)
            labelYourScore.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive=true
            labelYourScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
            labelYourScore.widthAnchor.constraint(equalToConstant: 250).isActive=true
            labelYourScore.heightAnchor.constraint(equalToConstant: 80).isActive=true
            
            self.view.addSubview(labelScore)
            labelScore.topAnchor.constraint(equalTo: labelYourScore.bottomAnchor, constant: 0).isActive=true
            labelScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
            labelScore.widthAnchor.constraint(equalToConstant: 150).isActive=true
            labelScore.heightAnchor.constraint(equalToConstant: 60).isActive=true
            labelScore.text = "\(score) / \(totalScore!)"
            
            
            self.view.addSubview(buttonRestart)
                 buttonRestart.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 40).isActive=true
                 buttonRestart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
                 buttonRestart.widthAnchor.constraint(equalToConstant: 150).isActive=true
                 buttonRestart.heightAnchor.constraint(equalToConstant: 50).isActive=true
                 buttonRestart.addTarget(self, action: #selector(buttonRestartAction), for: .touchUpInside)}
    }
    
    
    let labelYourScore: UILabel = {
        let label=UILabel()
        label.text="Deine Leistung:"
        label.textColor=UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26)
        label.numberOfLines=2
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    
    let labelScore: UILabel = {
        let label=UILabel()
        label.text="0 / 0"
        label.textColor=UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let labelOponent: UILabel = {
        let label=UILabel()
        label.text="Leistung deines Gegners:"
        label.textColor=UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26)
        label.numberOfLines=2
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let labelOponentScore: UILabel = {
        let label=UILabel()
        label.text="0 / 0"
        label.textColor=UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let labelRating: UILabel = {
        let label=UILabel()
        label.textColor=UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.numberOfLines=2
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let buttonRestart: UIButton = {
        let button = UIButton()
        button.setTitle("Restart", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor=UIColor.orange
        button.layer.cornerRadius=5
        button.clipsToBounds=true
        button.translatesAutoresizingMaskIntoConstraints=false
        return button
    }()
    
}


