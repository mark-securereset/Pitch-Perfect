//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Mark Boyle on 2015-03-11.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var audioPlayer2:AVAudioPlayer!
    var audioEngine:AVAudioEngine!
    var receivedAudio:RecordedAudio!
    var audioFile:AVAudioFile!
    
    func playAudioWithVariableSpeed(speed: Float){
        if(speed >= 0.5 && speed <= 2.0){
            println("Stopping Player")
            audioEngine.stop()
            audioEngine.reset()
            audioPlayer.stop()
            audioPlayer.currentTime = 0.0
            audioPlayer.rate = speed
            audioPlayer.play()
        } else {
            println("Invalid rate specified")
        }        
    }

    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }

    func playEcho() {
        audioPlayer.stop()
        audioPlayer.rate = 1.0
        audioPlayer.currentTime = 0;
        audioPlayer.play()
        
        
        let delay:NSTimeInterval = 0.2//100ms
        var playtime:NSTimeInterval
        playtime = audioPlayer2.deviceCurrentTime + delay
        audioPlayer2.stop()
        audioPlayer2.currentTime = 0
        audioPlayer2.volume = 0.8;
        audioPlayer2.playAtTime(playtime)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer2 = AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL, error: nil)
        audioPlayer.enableRate = true
        audioFile = AVAudioFile(forReading: receivedAudio.filePathURL, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playNormally(sender: UIButton) {
        //play audio at normal rate and pitch
        playAudioWithVariableSpeed(1.0)
    }
    @IBAction func playChipmunkly(sender: UIButton) {
        //play audio with chipmunk effect
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playEcho(sender: UIButton) {
        //play audio with echo effect
        playEcho()
    }
    @IBAction func playQuickly(sender: UIButton) {
        //Play audio quickly
        playAudioWithVariableSpeed(2.0)
     }

    @IBAction func playVaderly(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    @IBAction func playSlowly(sender: UIButton) {
        //Play audio slowly
        playAudioWithVariableSpeed(0.5)
    }
    @IBAction func playStop(sender: UIButton) {
        //stop playing of audio file
        audioPlayer.stop()
        audioEngine.stop()
    }
 }
