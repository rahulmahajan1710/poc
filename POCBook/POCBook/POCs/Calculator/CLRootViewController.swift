//
//  CLRootViewController.swift
//  POCBook
//
//  Created by rahul mahajan on 27/01/17.
//  Copyright © 2017 rahul mahajan. All rights reserved.
//

import UIKit

var count = 0

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
        count += 1
        print("VDL Count: \(count)")
        brain.addUnaryOperation(symbol: "Z"){[weak weakSelf = self ] in
            weakSelf?.displayLbl.textColor = UIColor.red
            return sqrt($0)
        }
    }
    
    deinit {
        count -= 1
        print("Left Count: \(count)")
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
    var savedProgram : CLCalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil {
            brain.program = savedProgram!
            displayValue = brain.result
        }
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
