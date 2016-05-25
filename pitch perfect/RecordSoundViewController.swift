//
//  RecordSoundViewController.swift
//  pitch perfect
//
//  Created by Shu-Mei Cheng on 1/17/16.
//  Copyright © 2016 Shu-Mei Cheng. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController ,AVAudioRecorderDelegate{
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var micbutton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if(flag == true){
            print("in finish Recording\n")
            
        // save the recorded audio
            recordedAudio = RecordedAudio()
            recordedAudio.initit(recorder.url, titleName: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecord", sender: recordedAudio)
        }else{
            print("error recording\n")
            stopButton.hidden = true
            micbutton.enabled = true
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //recordingLabel.hidden = true
    }
    override func viewWillAppear(animated: Bool) {
        recordingLabel.hidden = false
        recordingLabel.text = "Tap to Record"
        stopButton.hidden = true
        micbutton.enabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecord"){
            // get the viewController from segue
            let playSoundsVC:PlaySoundViewController = segue.destinationViewController as! PlaySoundViewController
            let data = sender as! RecordedAudio
            
            playSoundsVC.receivedAudio = data
        }
    }

    @IBAction func record(sender: UIButton) {
        print("in recording");
        
        recordingLabel.hidden = false
        recordingLabel.text = "Recording"
        stopButton.hidden = false
        micbutton.enabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let recordingName = "myRecording.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        audioRecorder.delegate = self

        
    }
    

    @IBAction func stop(sender: UIButton) {
    
        recordingLabel.hidden = true
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)

  
    }

}