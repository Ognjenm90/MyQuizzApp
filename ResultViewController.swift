//
//  ResultViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 25.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//


import UIKit

class ResultViewController: UIViewController {
    
    var score: Int?
    var totalScore: Int?
    var window: UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setupViews()
    }
    
    func showRating() {
        var rating = ""
        var color = UIColor.black
        guard let sc = score, let tc = totalScore else { return }
        let s = sc * 100 / tc
        if s < 10 {
            rating = "Poor"
            color = UIColor.darkGray
        }  else if s < 40 {
            rating = "Average"
            color = UIColor.blue
        } else if s < 60 {
            rating = "Good"
            color = UIColor.yellow
        } else if s < 80 {
            rating = "Excellent"
            color = UIColor.red
        } else if s <= 100 {
            rating = "Outstanding"
            color = UIColor.orange
        }
        labelRating.text = "\(rating)"
        labelRating.textColor=color
    }
    
    @objc func buttonRestartAction() {
       
      self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
         
    }
    
    func setupViews() {
        self.view.addSubview(labelTitle)
        labelTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive=true
        labelTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelTitle.widthAnchor.constraint(equalToConstant: 250).isActive=true
        labelTitle.heightAnchor.constraint(equalToConstant: 80).isActive=true
       
        self.view.addSubview(labelScore)
        labelScore.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 0).isActive=true
        labelScore.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelScore.widthAnchor.constraint(equalToConstant: 150).isActive=true
        labelScore.heightAnchor.constraint(equalToConstant: 60).isActive=true
        labelScore.text = "\(score!) / \(totalScore!)"
        
        self.view.addSubview(labelRating)
        labelRating.topAnchor.constraint(equalTo: labelScore.bottomAnchor, constant: 40).isActive=true
        labelRating.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        labelRating.widthAnchor.constraint(equalToConstant: 150).isActive=true
        labelRating.heightAnchor.constraint(equalToConstant: 60).isActive=true
        showRating()
        
        self.view.addSubview(buttonRestart)
        buttonRestart.topAnchor.constraint(equalTo: labelRating.bottomAnchor, constant: 40).isActive=true
        buttonRestart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        buttonRestart.widthAnchor.constraint(equalToConstant: 150).isActive=true
        buttonRestart.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonRestart.addTarget(self, action: #selector(buttonRestartAction), for: .touchUpInside)
    }
    
    let labelTitle: UILabel = {
        let label=UILabel()
        label.text="Your Score"
        label.textColor=UIColor.darkGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 46)
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
    
    let labelRating: UILabel = {
        let label=UILabel()
        label.text="Good"
        label.textColor=UIColor.black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
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
