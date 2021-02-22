//
//  QuizViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 20.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
extension QuizViewController: QuizView {
    
    func showLoading(withTitle title: String?) {
        showLoading(withView: self.view, andTitle: title)
    }
    
    func stopLoading() {
        hideLoading()
    }
}
class QuizViewController: BaseViewController , UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    var opponentScore: Int? = nil{
        
        didSet { //called when item changes
            DispatchQueue.main.async {
                self.setAlertView(text: "Dein Gegner ist fertig")
            }
        }
        willSet {
            print("Gegner ist fertig")
        }
    }
    
    var presenter: QuizPresenter!
    var window: UIWindow?
    var myCollectionView: UICollectionView!
    let scoreService = ScoreService()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        QuizPresenter.config(withQuizViewController: self)
    }
    
    var name:String = ""
    var gameType:String = ""
    var filteredQuestions : [QuestionViewModel] = []
    var score: Int = 0
    var currentQuestionNumber = 1
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(QuestionsDataSingleton.sharedInstance.sharedFilteredQuestions.count != 0 ){
            self.filteredQuestions = QuestionsDataSingleton.sharedInstance.sharedFilteredQuestions
        }
        return self.filteredQuestions.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) ->  UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizViewControllerCell
        
        
        cell.delegate=self

        if(filteredQuestions.count == indexPath.row){
            cell.question = filteredQuestions[indexPath.row-1]
        }else{
            cell.question = filteredQuestions[indexPath.row]
        }
        return cell
    }
    
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let deadlineTime = DispatchTime.now() + .seconds(2)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
        }
        questionNummerLabel.text = "Question: 1 / \(filteredQuestions.count)"
        scoreLabel.text = "Score: 0 / \(filteredQuestions.count)"
    }
    
    
    func setWholeView(){
        
        self.scoreService.delegate = self
        UserDefaults.standard.set("score", forKey: "quizzScore")
        UserDefaults.standard.synchronize()
        
        
        self.title="Home"
        self.view.backgroundColor=UIColor.white
        
        
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        
        
        self.myCollectionView=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        
        
        
        self.myCollectionView=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
        self.myCollectionView.delegate=self
        self.myCollectionView.dataSource=self
        self.myCollectionView.register(QuizViewControllerCell.self, forCellWithReuseIdentifier: "Cell")
        self.myCollectionView.showsHorizontalScrollIndicator = false
        self.myCollectionView.translatesAutoresizingMaskIntoConstraints=false
        self.myCollectionView.backgroundColor=UIColor.white
        self.myCollectionView.isPagingEnabled = true
        
        self.view.addSubview(self.myCollectionView)
        
        
        
        
        self.setupViews()
    }
    override func viewDidLoad() {
       

        super.viewDidLoad()
        self.setWholeView()
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setQuestionNumber()
    }
    func setQuestionNumber() {
        let x = myCollectionView.contentOffset.x
        let w = myCollectionView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        if currentPage < filteredQuestions.count {
            questionNummerLabel.text = "Question: \(currentPage + 1) / \(filteredQuestions.count)"
            currentQuestionNumber = currentPage + 1
        }
    }
    func setupViews() {
        
        myCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive=true
        myCollectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        myCollectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive=true
        
        self.view.addSubview(buttonPrev)
        buttonPrev.heightAnchor.constraint(equalToConstant: 50).isActive=true
        buttonPrev.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive=true
        buttonPrev.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive=true
        buttonPrev.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
        self.view.addSubview(buttonNext)
        buttonNext.heightAnchor.constraint(equalTo: buttonPrev.heightAnchor).isActive=true
        buttonNext.widthAnchor.constraint(equalTo: buttonPrev.widthAnchor).isActive=true
        buttonNext.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive=true
        buttonNext.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive=true
        
        
        self.view.addSubview(questionNummerLabel)
        questionNummerLabel.heightAnchor.constraint(equalToConstant: 20).isActive=true
        questionNummerLabel.widthAnchor.constraint(equalToConstant: 150).isActive=true
        questionNummerLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive=true
        questionNummerLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive=true
        questionNummerLabel.text = "Question: \(1) / \(filteredQuestions.count)"
        
        
        
        self.view.addSubview(scoreLabel)
        scoreLabel.heightAnchor.constraint(equalTo: questionNummerLabel.heightAnchor).isActive=true
        scoreLabel.widthAnchor.constraint(equalTo: questionNummerLabel.widthAnchor).isActive=true
        scoreLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive=true
        scoreLabel.bottomAnchor.constraint(equalTo: questionNummerLabel.bottomAnchor).isActive=true
        scoreLabel.text = "Score: \(score) / \(filteredQuestions.count)"
    }
    let buttonPrev: UIButton = {
        let button=UIButton()
        button.setTitle("< Previous", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor=UIColor.yellow
        button.translatesAutoresizingMaskIntoConstraints=false
        button.addTarget(self, action: #selector(buttonPrevNextAction), for: .touchUpInside)
        return button
    }()
    
    let buttonNext: UIButton = {
        let button=UIButton()
        button.setTitle("Next >", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor=UIColor.orange
        button.translatesAutoresizingMaskIntoConstraints=false
        button.addTarget(self, action: #selector(buttonPrevNextAction), for: .touchUpInside)
        return button
    }()
    
    let questionNummerLabel: UILabel = {
        let label=UILabel()
        label.text="0 / 0"
        label.textColor=UIColor.gray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label=UILabel()
        label.text="0 / 0"
        label.textColor=UIColor.gray
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints=false
        return label
    }()
    
    func goToResultView(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultViewController.score = score
        
        resultViewController.totalScore = filteredQuestions.count
        
        if(opponentScore != nil){
            self.present(resultViewController, animated:true, completion:nil)
        }else {
            print("Warte")
        }
    }
    func setAlertView(text: String){
        
        let alertController = UIAlertController(title: "Artikel", message: text,preferredStyle: .alert)
        alertController.view.backgroundColor = UIColor.white
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 200)
        alertController.view.addConstraint(height)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            // Perform Action
        })
        alertController.addAction(okAction)
        
        self.present(alertController ,animated: true)
        
    }
    
    
    //Passiert wenn man auf "Previous" oder "Next" klickt
    @objc func buttonPrevNextAction(sender: UIButton) {
        
        //Text des Buttons ist bei letztem fragen "Finisch"
        if(sender == buttonNext && currentQuestionNumber == filteredQuestions.count - 1){
            
            buttonNext.setTitle("Finisch", for: .normal)
            
        }
        
        
        //wenn man alleine spielt und fertig ist werden die andere Daten in ResultViewController übertragen
        if(gameType == "singleplayer"){
            if(sender == buttonNext && currentQuestionNumber == filteredQuestions.count){
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                resultViewController.score = score
                
                resultViewController.totalScore = filteredQuestions.count;
                
                
                self.present(resultViewController, animated:true, completion:nil)}}
            
            //wenn man fertig ist und mit dem Gegner Spielt und Gegner ist fertig
            
        else{
            if sender == buttonNext && currentQuestionNumber == filteredQuestions.count && opponentScore != nil {
                
                scoreService.send(score: String(score))
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
                resultViewController.score = score
                UserDefaults.standard.set("score", forKey: "quizzScore")
                resultViewController.gameType = "multiplayer"
                resultViewController.totalScore = filteredQuestions.count;
                resultViewController.opponentScore = opponentScore ?? 0;
                
                self.present(resultViewController, animated:true, completion:nil)
                  //wenn man fertig ist und mit dem Gegner Spielt und Gegner ist nicht fertig
            }else if (sender == buttonNext && currentQuestionNumber == filteredQuestions.count && opponentScore == nil){
                scoreService.send(score: String(score))
                setAlertView(text: "Dein Gegner ist noch nicht fertig, warte ein Moment bitte!!")
                
            }}
        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        
        //wenn man nicht fertig ist und auf "next" clickt kommt man zu nächster frage
        if sender == buttonNext {
            
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= filteredQuestions.count ? 0 : 1
            
            //wenn man auf "previous klickt"
        } else {
            
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x - collectionBounds.size.width))
            currentQuestionNumber -= currentQuestionNumber <= 0 ? 0 : 1
            
        }
        self.moveToFrame(contentOffset: contentOffset)
        questionNummerLabel.text = "Question: \(currentQuestionNumber) / \(filteredQuestions.count)"
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.myCollectionView.contentOffset.y ,width : self.myCollectionView.frame.width,height : self.myCollectionView.frame.height)
        self.myCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
}
extension QuizViewController: QuizCVCellDelegate {
    func didChooseAnswer(buttonIndex: Int) {
        let centerIndex = getCenterIndex()
        guard let index = centerIndex else { return }
        
        filteredQuestions[index.item].isAnswered = true
        if filteredQuestions[index.item].correct_answer != buttonIndex {
            filteredQuestions[index.item].incorrect_answer = buttonIndex
            score -= 1
        } else {
            score += 1
        }
        scoreLabel.text = "Score: \(score) / \(filteredQuestions.count)"
        myCollectionView.reloadItems(at: [index])
    }
    
    func getCenterIndex() -> IndexPath? {
        let center = self.view.convert(self.myCollectionView.center, to: self.myCollectionView)
        let index = myCollectionView!.indexPathForItem(at: center)
        print(index ?? "index not found")
        return index
    }
}


extension QuizViewController : ScoreServiceDelegate {
    func scoreChanged(manager: ScoreService, scoreString: String) {
        
        self.opponentScore = Int(scoreString)
        
    }
    func connectedDevicesChanged(manager: ScoreService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            
        }
    }
}
