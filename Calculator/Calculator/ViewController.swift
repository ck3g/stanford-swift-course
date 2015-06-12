//
//  ViewController.swift
//  Calculator
//
//  Created by Vitaly Tatarintsev on 6/10/15.
//  Copyright (c) 2015 Vitaly Tatarintsev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!

    var userInTheMiddleOfTypingANumber = false
    var userInTheMiddleOfTypingAPrecision = false

    @IBAction func appendDigit(sender: UIButton) {
        var digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func appendPi() {
        userInTheMiddleOfTypingANumber = false
        display.text = "\(M_PI)"
        enter()
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!

        if userInTheMiddleOfTypingANumber {
            enter()
        }

        switch operation {
        case "+": performOperation() { $0 + $1 }
        case "−": performOperation() { $1 - $0 }
        case "×": performOperation() { $0 * $1 }
        case "÷": performOperation() { $1 / $0 }
        case "√": performOperation() { sqrt($0) }
        case "Sin": performOperation() { sin($0) }
        case "Cos": performOperation() { cos($0) }
        default:
            break
        }
    }

    func addition(op1: Double, op2: Double) -> Double {
        return op1 + op2
    }

    var operandStack = Array<Double>()

    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        userInTheMiddleOfTypingAPrecision = false
        operandStack.append(displayValue)
        println("operandStack = \(operandStack)")
    }

    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userInTheMiddleOfTypingANumber = false
        }
    }

    @IBAction func floatDelimeter() {
        if !userInTheMiddleOfTypingAPrecision {
            display.text = display.text! + "."
            userInTheMiddleOfTypingAPrecision = true
        }
    }

    private func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }

    private func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }

}

