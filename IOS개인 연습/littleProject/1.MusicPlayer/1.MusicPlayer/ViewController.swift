//
//  ViewController.swift
//  1.MusicPlayer
//
//  Created by 전성훈 on 2023/05/07.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    
    //MARK: Properties
    var player: AVAudioPlayer?
    var timer: Timer!
    
    //MARK: - Methods
    //MARK: Custom Method
    func initializePlayer() {
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("error")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player!.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드: \(error.code), 메시지:\(error.localizedDescription)")
        }
        
        self.progressSlider.maximumValue = Float(self.player!.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player!.currentTime)
    }
    
    func updateTimeLabelText(time: TimeInterval) {
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute,second,milisecond)
        
        self.timeLabel.text = timeText
    }
    
    func makeAndFireTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [weak self] (timer: Timer) in
            guard let self = self else { return }
            if self.progressSlider.isTracking { return }
            
            self.updateTimeLabelText(time: self.player!.currentTime)
            self.progressSlider.value = Float(self.player!.currentTime)
        })
        self.timer.fire()
    }
    
    func invalidateTimer() {
        self.timer.invalidate()
        self.timer = nil
    }
    
    func trueSelected() {
        self.player!.play()
        self.makeAndFireTimer()
    }
    
    func falseSelected() {
        self.player!.pause()
        self.invalidateTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializePlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        guard sender.isSelected else {
            falseSelected()
            return
        }
        trueSelected()
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player!.currentTime = TimeInterval(sender.value)
    }
    
}

// MARK: AVAudioPlayerDelegate
extension ViewController: AVAudioPlayerDelegate {
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error: Error = error else {
            print("디코드 오류 발생")
            return
        }
        
        let message = "오디오 플레이어 오류 발생 \(error.localizedDescription)"
        
        let title = "오류 발생"
        
        let alert = audioEndAlert(title, message)
        
        self.present(alert, animated: true)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
        
        let message = "내 음악 어때?"
        
        let title = "작동 완료"
        
        let alert = audioEndAlert(title, message)
        
        self.present(alert, animated: true)
    }
    
    
}

//MARK: Alert Custom
extension ViewController {
    func audioEndAlert(_ title: String, _ message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        
        return alert
    }
    
}
