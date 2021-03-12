//
//  ViewController.swift
//  Flashcards
//
//  Created by hieungan on 2/20/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
        creationController.initialAnswer = backLabel.text
        creationController.initialQuestion = frontLabel.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        card.layer.cornerRadius = 20.0
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        btn1.layer.borderWidth = 3.0
        btn1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn1.layer.cornerRadius = 20.0
        btn2.layer.borderWidth = 3.0
        btn2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn2.layer.cornerRadius = 20.0
        btn3.layer.borderWidth = 3.0
        btn3.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        btn3.layer.cornerRadius = 20.0
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontLabel.isHidden {
            frontLabel.isHidden = false
        }
        else {
        frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String, extra1: String?, extra2: String?) {
        frontLabel.text = question
        backLabel.text = answer
        btn1.setTitle(extra1, for: .normal)
        btn2.setTitle(answer, for: .normal)
        btn3.setTitle(extra2, for: .normal)
    }
    @IBAction func didTapOption3(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    @IBAction func didTapOption2(_ sender: Any) {
        btn2.isHidden = true
    }
    @IBAction func didTapOption1(_ sender: Any) {
        btn1.isHidden = true
    }
}

