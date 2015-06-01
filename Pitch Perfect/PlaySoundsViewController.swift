//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Surasak Adulprasertsuk on 5/26/15.
//  Copyright (c) 2015 Surasak Adulprasertsuk. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func playeSlowAudio(sender: UIButton) {
        playAudioWithSpeed(0.5)
    }
    
    @IBAction func playFastAudio(sender: UIButton) {
        playAudioWithSpeed(1.5)
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func playReverbAudio(sender: UIButton) {
        playAudioWithReverb()
    }
    
    @IBAction func playEchoAudio(sender: UIButton) {
        playAudioWithEcho()
        
    }
    
    
    @IBAction func stopAudio(sender: UIButton) {
        stopAudio()
    }
    
    func playAudioWithSpeed(speed: Float) {
        stopAudio()
        audioPlayer.rate = speed
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    func playAudioWithEcho() {
        stopAudio()
        
        var audioDelayEffect = AVAudioUnitDelay()
        audioDelayEffect.delayTime = NSTimeInterval(0.3)
        
        playAudioEffect(audioDelayEffect)
    }
    
    func playAudioWithReverb() {
        stopAudio()
        
        var audioReverbEffect = AVAudioUnitReverb()
        audioReverbEffect.wetDryMix = 100
        
        playAudioEffect(audioReverbEffect)
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopAudio()
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        playAudioEffect(changePitchEffect)
    }
    
    func playAudioEffect(effect: AVAudioUnit) {
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        audioEngine.attachNode(effect)
        
        audioEngine.connect(audioPlayerNode, to: effect, format: nil)
        audioEngine.connect(effect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    func stopAudio() {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
}
