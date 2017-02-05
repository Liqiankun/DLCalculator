//
//  ViewController.swift
//  DLCalculator
//
//  Created by FT_David on 2016/12/10.
//  Copyright © 2016年 FT_David. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    var soundPlayer:AVAudioPlayer!
    @IBOutlet weak var counterLabel: UILabel!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValueString = ""
    var rightValueString = ""
    var resultString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSoundPlayer()
        counterLabel.text = "0"
    }
    
    @IBAction func numberButtonPress(sender: UIButton){
        playSound()
        runningNumber += "\(sender.tag)"
        counterLabel.text = runningNumber
    }
    
    @IBAction func divideButtonPress(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyButtonPress(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtractButtonPress(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addButtonPress(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalButtonPress(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }

    func setupSoundPlayer() {
        let soundPath = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL.init(fileURLWithPath:soundPath!)
        do {
            try  soundPlayer = AVAudioPlayer(contentsOf: soundURL)
            soundPlayer.prepareToPlay()
        }catch let error as NSError{
            print(error.debugDescription)
        }
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValueString = runningNumber
                runningNumber = ""
                if currentOperation == Operation.Multiply {
                    resultString = "\(Double(leftValueString)! * Double(rightValueString)!)"
                } else if currentOperation == Operation.Divide {
                    resultString = "\(Double(leftValueString)! / Double(rightValueString)!)"
                } else if currentOperation == Operation.Subtract {
                    resultString = "\(Double(leftValueString)! - Double(rightValueString)!)"
                } else if currentOperation == Operation.Add {
                    resultString = "\(Double(leftValueString)! + Double(rightValueString)!)"
                }
                leftValueString = resultString
                counterLabel.text = resultString
            }
            currentOperation = operation
        }else{
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
    
    func playSound() {
        if soundPlayer.isPlaying {
            soundPlayer.stop()
        }
        soundPlayer.play()
    }

}

