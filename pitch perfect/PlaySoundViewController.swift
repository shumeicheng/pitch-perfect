//
//  PlaySoundViewController.swift
//  pitch perfect
//
//  Created by Shu-Mei Cheng on 1/22/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    
    var receivedAudio:RecordedAudio!
    
    var audioEngine: AVAudioEngine!
    
    @IBAction func stopPlay(sender: AnyObject) {
        stopPlayerEngine()
    }
    func stopPlayerEngine(){
        audioPlayer.stop()
        audioEngine.stop()
        
    }
    
    //var player:AVPlayer!
    func playNow(rate: Float){
        stopPlayerEngine()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        audioPlayer.play()

    }
    
    func playPitch(pitch:Float)
    {   stopPlayerEngine()
        audioEngine.reset()
        
        var audioFile:AVAudioFile!
        do{
            try audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl)
        }
        catch {
            print("error audioFile");
        }
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode (audioPlayerNode)
        let changePitchEffect = AVAudioUnitTimePitch()
        audioEngine.attachNode(changePitchEffect)
        changePitchEffect.pitch = pitch
        audioEngine.connect(audioPlayerNode, to:changePitchEffect,format:nil)
        audioEngine.connect(changePitchEffect,to: audioEngine.outputNode,format:nil)
        try! audioEngine.start()
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do{
            try audioEngine.start()
        }catch{
            print ("audioEngine error")
        }
        //audioEngine.stop()
        //audioPlayerNode.stop()
        audioPlayerNode.play()

        
    }
    
    @IBAction func playDar(sender: UIButton) {
        playPitch(-1000)
    }
    
    @IBAction func playChipmunk(sender: UIButton) {
        playPitch(1000)
    }
    
    @IBAction func playFast(sender: AnyObject) {
        playNow(1.5)
    }
    
    @IBAction func playSlow(sender: UIButton) {
        //player.play()
        playNow(0.5)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
        audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, fileTypeHint:nil)
        
        }catch {
            print ("audioPlayer nil");
            
        }
        
        audioPlayer.enableRate = true
        
        audioEngine = AVAudioEngine()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
