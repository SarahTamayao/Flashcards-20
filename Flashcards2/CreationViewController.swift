//
//  CreationViewController.swift
//  Flashcards2
//
//  Created by Elizabeth Lee on 3/18/22.
//

import UIKit

class CreationViewController: UIViewController {

    var flashcardsController: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answerTextField: UITextField!
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        // get text in question text field
        let questionText = questionTextField.text
        
        // get text in answer text field
        let answerText = answerTextField.text
        
        // check if the text fields are empty, if yes, error alert will pop up
        if questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty {
            // create error alert
            let alert = UIAlertController(title: "Missing text", message: "Please input both question and answer", preferredStyle: UIAlertController.Style .alert)
            
            // show error alert
            present(alert, animated: true)
        } else {
            // if text fields are not empty
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
            
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
