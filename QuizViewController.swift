//
//  QuizViewController.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 20.04.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import UIKit


class QuizViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   var window: UIWindow?
    var myCollectionView: UICollectionView!
  
  
    
    var filteredQuestions : [QuestionViewModel]
       {
           return questionsArray.filter {
               $0.selected
           }
       }
   
    
      var questionsArray = [QuestionViewModel]()
      var score: Int = 0
      var currentQuestionNumber = 1
      
  
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! QuizViewControllerCell
        
     
      cell.delegate=self
        print("count",filteredQuestions.count)
      cell.question = filteredQuestions[indexPath.row]
      
               return cell
    }
    

    func getData(){
        if let path = Bundle.main.path(forResource: "questions", ofType: "json") {
                            do {
                                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                                let decoder = JSONDecoder()
                                do {
                       // get the data from JSON file with help of struct and Codable
                                    let questionJSON = try decoder.decode([QuestionJSON].self, from: data)
                       // from here you can populate data in tableview
                                    print("modeljson",questionJSON[0])
                                   for q in questionJSON {
                                                
                                      // questionsArray.append(QuestionPresenter.present(entity: q))
                                       QuestionsDataSingleton.sharedInstance.sharedQuestions.append(QuestionPresenter.present(entity: q))
                                            }
                                   print("model",QuestionsDataSingleton.sharedInstance.sharedQuestions)

                                }catch{
                                    print(error) // shows error
                                    print("Decoding failed")// local message
                                }

                            } catch {
                                print(error) // shows error
                                print("Unable to read file")// local message
                            }
                        }
        
    }
        override func viewDidLoad() {
       
        super.viewDidLoad()
      
        self.title="Home"
        self.view.backgroundColor=UIColor.white

      getData()

            let layout = UICollectionViewFlowLayout()
                   layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                   layout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
                   layout.scrollDirection = .horizontal
                   layout.minimumLineSpacing = 1
                   layout.minimumInteritemSpacing = 1
            
            
            
          myCollectionView=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
            
         
           
              myCollectionView=UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), collectionViewLayout: layout)
                     myCollectionView.delegate=self
                     myCollectionView.dataSource=self
                     myCollectionView.register(QuizViewControllerCell.self, forCellWithReuseIdentifier: "Cell")
                     myCollectionView.showsHorizontalScrollIndicator = false
                     myCollectionView.translatesAutoresizingMaskIntoConstraints=false
                     myCollectionView.backgroundColor=UIColor.white
                     myCollectionView.isPagingEnabled = true
                     
                     self.view.addSubview(myCollectionView)
   


//                  let que1 = Question(category: "Entertainment: Video Games",type:"multiple", questionText: "What is 2 x 2 ?", options: ["2", "8", "6","4"],incorrect_answer: -1, correct_answer: 1,  isAnswered: false,difficulty: "easy")
//                  let que2 = Question(category: "Entertainment: Video Games",type:"multiple", questionText: "papapapa ?", options: ["2", "8", "6","4"],incorrect_answer: -1, correct_answer: 1,  isAnswered: false,difficulty: "easy")
//                  let que3 = Question(category: "Entertainment: Video Games",type:"bool", questionText: "papapapa ?", options: ["true","false"],incorrect_answer: -1, correct_answer: 1,  isAnswered: false,difficulty: "easy")
//                 let que4 = Question(category: "Entertainment: Video Games",type:"multiple", questionText: "4 ?", options: ["2", "8", "6","4"],incorrect_answer: -1, correct_answer: 1,  isAnswered: false,difficulty: "easy")
//                  let que5 = Question(category: "Entertainment: Video Games",type:"multiple", questionText: "5 ?", options: ["2", "8", "6","4"],incorrect_answer: -1, correct_answer: 1,  isAnswered: false,difficulty: "easy")
//
//        questionsArray = [que1,que2,que3,que4,que5]
          //  filteredQuestions = questionsArray
           questionsArray = QuestionsDataSingleton.sharedInstance.sharedQuestions
       setupViews()
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
    

    @objc func buttonPrevNextAction(sender: UIButton) {
        
if sender == buttonNext && currentQuestionNumber == filteredQuestions.count {
  
    let vc = (storyboard!.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController)!
        vc.score = score
        vc.totalScore = filteredQuestions.count
    
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
    resultViewController.score = score
   resultViewController.totalScore = filteredQuestions.count
    self.present(resultViewController, animated:true, completion:nil)

        return
    
 
        }
        let collectionBounds = self.myCollectionView.bounds
        var contentOffset: CGFloat = 0
        if sender == buttonNext {
             
          
            
            contentOffset = CGFloat(floor(self.myCollectionView.contentOffset.x + collectionBounds.size.width))
            currentQuestionNumber += currentQuestionNumber >= filteredQuestions.count ? 0 : 1
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

