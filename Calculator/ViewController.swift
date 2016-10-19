//
//  ViewController.swift
//  Calculator
//
//  Created by Saumeel Gajera on 10/18/16.
//  Copyright © 2016 Saumeel Gajera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userInMiddleOfTypingNumber = false
    
    @IBAction func appendDigit(sender: UIButton){
        let digit = sender.currentTitle!
        if userInMiddleOfTypingNumber{
            display.text = display.text! + digit
        }else{
            display.text = digit
            userInMiddleOfTypingNumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton){
        let operation = sender.currentTitle!
        if userInMiddleOfTypingNumber{
            enter()
        }
        switch operation {
            /*
             the simplifies version is equal to what we have below
             case "×": performOperation({ (op1: Double, op2: Double) -> Double in
                        return op1 * op2
                    })
             */
        case "×": performOperation { $0 * $1 }
        case "÷": performOperation { $1 / $0 }
        case "+": performOperation { $0 + $1 }
        case "−": performOperation { $1 - $0 }
        case "√": performOperation { sqrt($0) }
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if  operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    @nonobjc // we require this or either make the functions private
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter(){
        userInMiddleOfTypingNumber = false
        operandStack.append(displayValue)
        print("operand stack : \(operandStack)")

    }
 
    var displayValue: Double {
        get{
            return (display.text! as NSString).doubleValue
//            return NSNumberFormatter().numberFromString(display.text! as String)!.doubleValue
        }
        set{
            display.text = "\(newValue)"
            userInMiddleOfTypingNumber = false
            /* if you have displayValue = 5 anywhere in the code.
             newValue will have that 5 */
        }
    }
}

