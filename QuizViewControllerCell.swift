//
//  QuizViewControllerCell.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 20.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation


import UIKit


protocol QuizCVCellDelegate: class {
    func didChooseAnswer(buttonIndex: Int)
}

class QuizViewControllerCell: UICollectionViewCell {
    
    
    
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!

    
    var buttonsArray = [UIButton]()
    var label:UILabel!
   
    weak var delegate: QuizCVCellDelegate?
    
    var question: QuestionViewModel? {
        didSet {
            guard let notAnsweredQuestion = question else { return }
            
            if(notAnsweredQuestion.type == "multiple"){
            questionLabel.text = notAnsweredQuestion.questionText
                
                  button1.setTitle(notAnsweredQuestion.options[0], for: .normal)
                  button2.setTitle(notAnsweredQuestion.options[1], for: .normal)
                  button3.setTitle(notAnsweredQuestion.options[2], for: .normal)
                  button4.setTitle(notAnsweredQuestion.options[3], for: .normal)
                
            }
            else{
                           questionLabel.text = notAnsweredQuestion.questionText
                                   button1.setTitle(notAnsweredQuestion.options[0], for: .normal)
                                   button2.setTitle(notAnsweredQuestion.options[1], for: .normal)
                                   button3.removeFromSuperview()
                                   button4.removeFromSuperview()}
                           
                       
            if notAnsweredQuestion.isAnswered {
                buttonsArray[notAnsweredQuestion.correct_answer].backgroundColor=UIColor.green
                if notAnsweredQuestion.incorrect_answer >= 0 {
                    buttonsArray[notAnsweredQuestion.incorrect_answer].backgroundColor=UIColor.red
                }
            }
        }
    }
    
    
   
    
    required init?(coder: NSCoder) {
       
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        buttonsArray = [button1, button2, button3, button4]
    }
  
    @objc func buttonOptionAction(sender: UIButton) {
           
        guard let notAnsweredQuestion = question else { return }
        
        if !notAnsweredQuestion.isAnswered {
            
                        delegate?.didChooseAnswer(buttonIndex: sender.tag)
        }
        
    }
  
       
    override func prepareForReuse() {
        button1.backgroundColor=UIColor.white
        button2.backgroundColor=UIColor.white
        button3.backgroundColor=UIColor.white
        button4.backgroundColor=UIColor.white
    }
    
       
      
    func setupViews() {
    
           
           let buttonWidth: CGFloat = 150
           let buttonHeight: CGFloat = 50
           button1 = getButton(tag: 0)
           
        addSubview(questionLabel)
       questionLabel.topAnchor.constraint(equalTo:  self.topAnchor).isActive=true
       questionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12).isActive=true
       questionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12).isActive=true
       questionLabel.heightAnchor.constraint(equalToConstant: 150).isActive=true
        
           addSubview(button1)
           NSLayoutConstraint.activate([button1.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20), button1.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), button1.widthAnchor.constraint(equalToConstant: buttonWidth), button1.heightAnchor.constraint(equalToConstant: buttonHeight)])
           button1.addTarget(self, action: #selector(buttonOptionAction), for: .touchUpInside)
           button2 = getButton(tag: 1)
           addSubview(button2)
           NSLayoutConstraint.activate([button2.topAnchor.constraint(equalTo: button1.topAnchor), button2.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), button2.widthAnchor.constraint(equalToConstant: buttonWidth), button2.heightAnchor.constraint(equalToConstant: buttonHeight)])
           button2.addTarget(self, action: #selector(buttonOptionAction), for: .touchUpInside)
           
           button3 = getButton(tag: 2)
           addSubview(button3)
           NSLayoutConstraint.activate([button3.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20), button3.rightAnchor.constraint(equalTo: self.centerXAnchor, constant: -10), button3.widthAnchor.constraint(equalToConstant: buttonWidth), button3.heightAnchor.constraint(equalToConstant: buttonHeight)])
           button3.addTarget(self, action: #selector(buttonOptionAction), for: .touchUpInside)
           
           button4 = getButton(tag: 3)
           addSubview(button4)
           NSLayoutConstraint.activate([button4.topAnchor.constraint(equalTo: button3.topAnchor), button4.leftAnchor.constraint(equalTo: self.centerXAnchor, constant: 10), button4.widthAnchor.constraint(equalToConstant: buttonWidth), button4.heightAnchor.constraint(equalToConstant: buttonHeight)])
           button4.addTarget(self, action: #selector(buttonOptionAction), for: .touchUpInside)

       }
       
       func getButton(tag: Int) -> UIButton {
           let button=UIButton()
           button.tag=tag
           button.setTitle("Option", for: .normal)
           button.setTitleColor(UIColor.black, for: .normal)
           button.backgroundColor=UIColor.white
           button.layer.borderWidth=1
           button.layer.borderColor=UIColor.darkGray.cgColor
           button.layer.cornerRadius=5
           button.clipsToBounds=true
           button.translatesAutoresizingMaskIntoConstraints=false
           return button
       }
    
    let questionLabel: UILabel = {
        let label=UILabel()
        label.text="This is a question and you have to answer it?"
        label.textColor=UIColor.black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines=4
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
  
    
    
    
    
    
}









    
