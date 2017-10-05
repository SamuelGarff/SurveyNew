//
//  SurveyViewController.swift
//  SurveyNew
//
//  Created by Sam Bryson on 10/5/17.
//  Copyright © 2017 SamuelGBryson. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {
    
    // Outlets and actions
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emojiTextField: UITextField!
    
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        guard let name = nameTextField.text, let emoji = emojiTextField.text, name != "", !emoji.isEmpty else { return }
        
        SurveyController.shared.putSurvey(with: name, emoji: emoji) { (success) in
            
            guard success else { return }
            
            DispatchQueue.main.async {
                
                // this clears the text field
                
                self.nameTextField.text = ""
                self.emojiTextField.text = ""
                
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
