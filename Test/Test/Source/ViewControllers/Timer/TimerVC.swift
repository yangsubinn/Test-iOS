//
//  TimerVC.swift
//  Test
//
//  Created by 양수빈 on 2022/01/05.
//

import UIKit

import SnapKit

class TimerVC: UIViewController {
    
    let stopwatch: Stopwatch = Stopwatch()
    var isPlay: Bool = false
    
    var timerLabel = UILabel()
    var resetButton = UIButton()
    var startButton = UIButton() /// start-pause
    var stopTimeLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setUI()
        setAddTarget()
    }
    
    func setLayout() {
        view.addSubview(timerLabel)
        view.addSubview(resetButton)
        view.addSubview(startButton)
        view.addSubview(stopTimeLabel)
        
        timerLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(300)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(80)
            make.width.height.equalTo(100)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().inset(80)
            make.width.height.equalTo(100)
        }
        
        stopTimeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(resetButton.snp.bottom).offset(40)
        }
    }
    
    func setUI() {
        timerLabel.text = "00:00:00"
        timerLabel.font = .systemFont(ofSize: 40)
        
        stopTimeLabel.text = "-"
        
        startButton.setTitle("start", for: .normal)
        resetButton.setTitle("reset", for: .normal)
        
        startButton.backgroundColor = .blue
        resetButton.backgroundColor = .red
        
        startButton.layer.cornerRadius = 50
        resetButton.layer.cornerRadius = 50
    }
    
    func setAddTarget() {
        startButton.addTarget(self, action: #selector(playPauseTimer(_:)), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetTimer(_:)), for: .touchUpInside)
    }
    
    @objc
    func playPauseTimer(_ sender: AnyObject) {
        // isPlay가 false이면 멈춤
        if !isPlay {
            unowned let weakSelf = self
            
            stopwatch.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(stopwatch.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(startButton, title: "Stop", titleColor: UIColor.white)
        } else {
            print("------timerLabel: \(timerLabel.text)")
            stopTimeLabel.text = timerLabel.text
            
            stopwatch.timer.invalidate()
            isPlay = false
            changeButton(startButton, title: "Start", titleColor: UIColor.white)
        }
    }
    
    @objc
    func resetTimer(_ sender: AnyObject) {
        if !isPlay {
            resetMainTimer()
        } else {
            print("먼저 멈추지?")
        }
    }
    
    fileprivate func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
      button.setTitle(title, for: UIControl.State())
      button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    fileprivate func resetMainTimer() {
      resetTimer(stopwatch, label: timerLabel)
    }
    
    fileprivate func resetTimer(_ stopwatch: Stopwatch, label: UILabel) {
      stopwatch.timer.invalidate()
      stopwatch.counter = 0.0
      label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
      updateTimer(stopwatch, label: timerLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwatch, label: UILabel) {
      stopwatch.counter = stopwatch.counter + 0.035
      
      var minutes: String = "\((Int)(stopwatch.counter / 60))"
      if (Int)(stopwatch.counter / 60) < 10 {
        minutes = "0\((Int)(stopwatch.counter / 60))"
      }
      
      var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
      if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
        seconds = "0" + seconds
      }
      
      label.text = minutes + ":" + seconds
    }
}

// MARK: - Extension
fileprivate extension Selector {
    static let updateMainTimer = #selector(TimerVC.updateMainTimer)
}
