//
//  ViewController.swift
//  Project2_100days
//
//  Created by user226947 on 12/11/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var currentQuestion = 0
    
    let maxQuestion = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries += ["estonia", "france", "germany",
                      "ireland", "italy", "monaco",
                      "nigeria", "poland", "russia",
                      "spain", "uk", "us"]
        
        button1.layer.borderWidth = 6
        button2.layer.borderWidth = 6
        button3.layer.borderWidth = 6
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
        
    }
    func askQuestion(action: UIAlertAction! = nil) {
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        currentQuestion += 1
        
        
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        UIView.transition(with: button1, duration: 0.5, options: .transitionFlipFromRight, animations: { [self] in
            self.button1.setImage(UIImage(named: self.countries[0]), for: .normal)
        }, completion: nil)
        
        UIView.transition(with: button2, duration: 0.7, options: .transitionFlipFromRight, animations: { [self] in
            self.button2.setImage(UIImage(named: self.countries[1]), for: .normal)
            
        }, completion: nil)
        
        UIView.transition(with: button3, duration: 0.9, options: .transitionFlipFromRight, animations: { [self] in
            self.button3.setImage(UIImage(named: self.countries[2]), for: .normal)
            
        }, completion: nil)

        //button1.setImage(UIImage(named: countries[0]), for: .normal)
        //button2.setImage(UIImage(named: countries[1]), for: .normal)
        //button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        updateTitle()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct!"
            score += 1
            message = "Score: \(score)"
                                          
            (sender as UIButton).layer.borderColor = UIColor.green.cgColor
            
            updateTitle()
            
            if currentQuestion < maxQuestion {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    self.askQuestion()
                });
            }
            else {
                gameOver()
            }
            
        }
        else {
            title = "Wrong!"
            
            score -= 1
            message = "Correct answer is a flag number \(correctAnswer + 1)"
            postAlert(title: title, message: message, sender_tag: sender.tag, correct: correctAnswer)
            
            
        }
    }
    
    func updateTitle() {
        title = "| \(countries[correctAnswer].uppercased())? | SCORE: \(score) | ROUND: \(currentQuestion)/\(maxQuestion) |"
    }
    
    func gameOver() {
        let scoreFinal = score
        
        score = 0
        correctAnswer = 0
        currentQuestion = 0
        
        let ac = UIAlertController(title: "Game over!", message: "Your score is \(scoreFinal)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: askQuestion))
        
        present(ac, animated: true)
    }
    
    func postAlert(title: String, message: String, sender_tag: Int, correct: Int) {
        updateTitle()
        
        if sender_tag == 0 {
            button1.layer.borderColor = UIColor.red.cgColor
        } else if sender_tag == 1 {
            button2.layer.borderColor = UIColor.red.cgColor
        } else if sender_tag == 2 {
            button3.layer.borderColor = UIColor.red.cgColor
        }
        
        if correct == 0 {
            button1.layer.borderColor = UIColor.green.cgColor
        } else if correct == 1 {
            button2.layer.borderColor = UIColor.green.cgColor
        } else if correct == 2 {
            button3.layer.borderColor = UIColor.green.cgColor
        }      //let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      //self.present(alert, animated: true, completion: nil)

      DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        //alert.dismiss(animated: true, completion: nil)
        
          
        if self.currentQuestion < self.maxQuestion {
            self.askQuestion()
        }
        else {
            self.gameOver()
        }
          
      })
    }}
