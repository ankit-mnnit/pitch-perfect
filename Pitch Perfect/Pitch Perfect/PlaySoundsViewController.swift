//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Ankit Garg on 17/03/15.
//  Copyright (c) 2015 Ankit Garg. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var player : AVAudioPlayer! = nil
    
    var audioEngine: AVAudioEngine!
    var audioFile:AVAudioFile!
    
    var receivedAudio:RecordedAudio!
    
    @IBOutlet weak var reallySlow: UIButton!
    @IBOutlet weak var reallyFast: UIButton!
    @IBOutlet weak var chipmunk: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if var filePath = NSBundle.mainBundle().pathForResource(receivedAudio.filePathUrl, ofType: "wav") {
//            var fileURLPath = NSURL.fileURLWithPath(filePath)
//            
//        } else {
//            println("There was some error in filepath")
//        }
        
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        player.enableRate = true
        audioEngine = AVAudioEngine()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func reallySlowAudio(sender: UIButton) {
        reallySlow.enabled = false
        reallyFast.enabled = true
        //playAudio(0.5)
        player.stop()
        player.rate = 0.5
        player.play()
        
    }

    @IBAction func reallyFastAudio(sender: UIButton) {
        audioEngine.stop()
        reallySlow.enabled = true
        reallyFast.enabled = false
        player.stop()
        player.rate = 2.0
        player.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        player.stop()
        audioEngine.stop()
        
        if (!reallySlow.enabled) {
            reallySlow.enabled = true
        } else {
            reallyFast.enabled = true
        }
    }
    
    @IBAction func applyChipmunkEffect(sender: UIButton) {
        audioEngine.stop()
        playSoundWithPitch(1000)
        
        
    }
    
    
    @IBAction func applyDarthVaderEffect(sender: UIButton) {
        audioEngine.stop()
        playSoundWithPitch(-1000)
    }
    
    
    func playSoundWithPitch(pitch: Float) {
        audioEngine.stop()
        var playerNode = AVAudioPlayerNode()
        audioEngine.attachNode(playerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(playerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        playerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        // Play the file
        playerNode.play()
    }
    
}
