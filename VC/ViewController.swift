//
//  ViewController.swift
//  Flashcards
//
//  Created by hieungan on 2/20/21.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var extra1: String
    var extra2: String
}

class ViewController: UIViewController {
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard]()
    
    // Current flashcard index
    var curIndex = 0
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var preBtn: UIButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardsController = self
        if segue.identifier == "EditSegue" {
        creationController.initialAnswer = backLabel.text
        creationController.initialQuestion = frontLabel.text
            creationController.initialEx1 = btn1.title(for: .normal)
            creationController.initialEx2 = btn2.title(for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        decoration()
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // adding our initial flashcar if needed
        if flashcards.count == 0 {
        updateFlashcard(question: "What's the most widely spoken language in the word?", answer: "Chinese", extra1: "English" , extra2: "Spanish", isExisting: false)
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if frontLabel.isHidden {
            frontLabel.isHidden = false
        }
        else {
        frontLabel.isHidden = true
        }
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurFlashcard() }
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    func deleteCurFlashcard() {
        // Delete current
        flashcards.remove(at: curIndex)
        // Special case: check if last card was deleted
        if curIndex > flashcards.count - 1 {
            curIndex = flashcards.count - 1
        }
        // re-update
        updateLabels()
        updateNextPrevButtons()
        saveAllFlashcardsToDisk()
    }
    
    func updateLabels() {
        // Get current flashcard
        let curFlashcard = flashcards[curIndex]
        // Update labels
        frontLabel.text = curFlashcard.question
        backLabel.text = curFlashcard.answer
        btn1.setTitle(curFlashcard.extra1, for: .normal)
        btn2.setTitle(curFlashcard.extra2, for: .normal)
        btn3.setTitle(curFlashcard.answer, for: .normal)
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // Increase current index
        curIndex = curIndex + 1
        
        // update labels
        updateLabels()
        // update buttons
        updateNextPrevButtons()
    }
    @IBAction func didTapOnPrev(_ sender: Any) {
        // Decrease current index
        curIndex = curIndex - 1
        
        // update labels
        updateLabels()
        // update buttons
        updateNextPrevButtons()
    }
    
    func updateFlashcard(question: String, answer: String, extra1: String, extra2: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, extra1: extra1, extra2: extra2)
        if isExisting {
            flashcards[curIndex] = flashcard
        } else {
        flashcards.append(flashcard)
        print("Added a new flashcard!")
        print("We now have \(flashcards.count) flashcards")
        // Update current index
        curIndex = flashcards.count - 1
        print("Our current index is \(curIndex)")
    }
        // Update buttons
        updateNextPrevButtons()
        
        // Update labels
        updateLabels()
        
        // save to disk
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons() {
        // Disable next button if at the end
        if curIndex == flashcards.count - 1 {
            nextBtn.isEnabled = false
        } else {
            nextBtn.isEnabled = true
        }
        // Disable prev button if at the beginning
        if curIndex == 0 {
            preBtn.isEnabled = false
        } else {
            preBtn.isEnabled = true
        }
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
    
    func saveAllFlashcardsToDisk() {
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String:String] in return ["question": card.question, "answer": card.answer, "extra1": card.extra1, "extra2": card.extra2] }
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        // Log it
        print("Flashcards saved to UserDefaults!")
    }
    
    func readSavedFlashcards() {
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            // In here we know for sure we have a dictionary
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extra1: dictionary["extra1"]!, extra2: dictionary["extra2"]!) }
            // Put all the cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
        
    }
    func decoration() {
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
}

