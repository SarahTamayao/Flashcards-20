//
//  ViewController.swift
//  Flashcards2
//
//  Created by Elizabeth Lee on 3/4/22.
//

import UIKit

struct Flashcard {
    var question : String
    var answer : String
}
class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
       
        
        // read saved flashcards
        readSavedFlashcards()
        
        //adding out initial flashcard if needed
        if flashcards.count == 0 {
        updateFlashcard(question: "Whats the capital of South Korea", answer: "Seoul")
        } else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }

    @IBAction func didTapOnPrev(_ sender: Any) {
        // decrease current index
        currentIndex = currentIndex - 1
        
        // update labels
        updateLabels()
        
        //update flashcards
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        // increase current index
        currentIndex = currentIndex + 1
        
        //update labels
        updateLabels()
        
        // update flashcards
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        flipFlashcard()
       
    }
    func flipFlashcard() {
    
            frontLabel.isHidden = true
        
        
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            
            self.frontLabel.isHidden = true
            
        })

        
        
        
       
        
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations:{
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y:0.0)
        }, completion: { finished in
            self.updateLabels() // Update labels
            self.animateCardIn() // Run other animation
        })
        
        

    }
    
    func animateCardIn() {
        // start on the right side (don't animate this)
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        
        // animate card going back to its original position
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
        }
    }
    func updateFlashcard(question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        
        flashcards.append(flashcard)
        print("added new flashcard")
        print("we now have \(flashcards.count) flashcards")
        
        currentIndex = flashcards.count - 1
        print("our current index is \(currentIndex)")
        
        //update buttons
        updateNextPrevButtons()
        
        // update labels
        updateLabels()
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        saveAllFlashcardsToDisk()
    }
    
    func updateNextPrevButtons(){
        
        // disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        }
        else {
            nextButton.isEnabled = true
        }
        
        // disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        }
        else {
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
    }
    
    // because if you exit the app, the flashcards disappear
    func saveAllFlashcardsToDisk() {
        // from flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return["question": card.question, "answer": card.answer]
        }
        
        // save array on disk using user defaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // log it
        print("flashcards saved on userdefaults")
    }
    
    
    func readSavedFlashcards() {
        // read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            // in here we know for sure there are dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            frontLabel.isHidden = false
            // put all cards in flashcard array
            flashcards.append(contentsOf: savedCards)
            
            
        }
        
        
    }
}

