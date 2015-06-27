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
    @IBOutlet weak var history: UILabel!

    var userInTheMiddleOfTypingANumber = false
    var userInTheMiddleOfTypingAPrecision = false

    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        var digit = sender.currentTitle!
        if userInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userInTheMiddleOfTypingANumber = true
        }
    }
    @IBAction func trackActivity(sender: UIButton) {
        var digit = sender.currentTitle!
        history.text = history.text! + digit
    }

    @IBAction func clearAll() {
        userInTheMiddleOfTypingANumber = false
        userInTheMiddleOfTypingAPrecision = false
        display.text = "0"
        operandStack = []
        history.text = ""
    }

    @IBAction func appendPi() {
        userInTheMiddleOfTypingANumber = false
        display.text = "\(M_PI)"
        enter()
    }

    @IBAction func operate(sender: UIButton) {
        if userInTheMiddleOfTypingANumber {
            enter()
        }

        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation) {
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }

    func addition(op1: Double, op2: Double) -> Double {
        return op1 + op2
    }

    var operandStack = Array<Double>()

    @IBAction func enter() {
        userInTheMiddleOfTypingANumber = false
        userInTheMiddleOfTypingAPrecision = false
        if let result = brain.pushOperand(displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
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

}

