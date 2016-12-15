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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSoundPlayer()
    }
    
    @IBAction func numberButtonPress(sender:UIButton){
        playSound()
        counterLabel.text = counterLabel.text?.appending("1")
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
    
    func playSound() {
        if soundPlayer.isPlaying {
            soundPlayer.stop()
        }
        soundPlayer.play()
    }

}

