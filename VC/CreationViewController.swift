//
//  CreationViewController.swift
//  Flashcards
//
//  Created by hieungan on 3/11/21.
//

import UIKit

class CreationViewController: UIViewController {
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBOutlet weak var extraAns1: UITextField!
    
    @IBOutlet weak var extraAns2: UITextField!
    
    
    var initialQuestion: String?
    var initialAnswer: String?
    
    override func viewDidLoad() {
        super.viewDidLoad() //comment...
        // Do any additional setup after loading the view.
        questionTextField.text = initialQuestion
        answerTextField.text = initialAnswer
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // Get the text in the question text field
        let questionText = questionTextField.text
        // Get the text in the answer text field
        let answerText = answerTextField.text
        // Call the function to update the flashcard
        let extraAnswer1 = extraAns1.text
        let extraAnswer2 = extraAns2.text
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            let alert = UIAlertController(title: "Missing text", message:"Need both a question and an answer", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(OKAction)
            present(alert, animated: true)
        }
        else {
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, extra1: extraAnswer1! , extra2: extraAnswer2!)
        dismiss(animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
