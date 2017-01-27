//
//  CLRootViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 27/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

class CLRootViewController: PBViewController {

    @IBOutlet private weak var displayLbl: UILabel!
    private var userIsInTheMiddleOfTyping = false
    private var brain = CLCalculatorBrain()
    
    private var displayValue : Double {
        set{
            displayLbl.text = String(newValue)
        }
        get{
            return Double(displayLbl.text!)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calculator Demo"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            displayLbl.text = displayLbl.text! + digit
        }
        else{
            displayLbl.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
    
    @IBAction func performOperation(_ sender: UIButton) {
        
        if userIsInTheMiddleOfTyping {
           brain.setOperand(operand: displayValue)
           userIsInTheMiddleOfTyping = false
        }
        
        if let mathsymbol = sender.currentTitle {
            brain.performOperation(symbol: mathsymbol)
        }
        
        displayValue = brain.result
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
