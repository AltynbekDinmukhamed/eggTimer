//
//  ViewController.swift
//  eggTimer
//
//  Created by Димаш Алтынбек on 29.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    //MARK: -View-
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let progress: UIProgressView = {
        let progress = UIProgressView()
        progress.progress = 0.5
        progress.progressTintColor = .white
        progress.trackTintColor = .darkGray
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    let progressView = UIView()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "How do you like eggs?"
        label.font = .systemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let eggStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let names = ["Soft", "Medium", "Hard"]
    
    var player = AVAudioPlayer()
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var timer = Timer()
    var totalTime = 0
    var secoundsPassed = 0
    
    //MARK: -LifeCycle-
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    //MARK: -SetUpViews-
    private func setUpViews() {
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            stack.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 5),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: stack.bottomAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: stack.trailingAnchor, multiplier: 5)
        ])
        
        stack.addArrangedSubview(label)
        
        for i in 0..<3 {
            let titles = names[i]
            let egg = EggView()
            egg.config(with: titles, self, action: #selector(didTapApp))
            eggStackView.addArrangedSubview(egg)
        }
        
        stack.addArrangedSubview(eggStackView)
        
        progressView.addSubview(progress)
        stack.addArrangedSubview(progressView)
        NSLayoutConstraint.activate([
            progress.leadingAnchor.constraint(equalToSystemSpacingAfter: progressView.leadingAnchor, multiplier: 1),
            progress.trailingAnchor.constraint(equalToSystemSpacingAfter: progressView.trailingAnchor, multiplier: 1),
            progress.bottomAnchor.constraint(equalToSystemSpacingBelow: progressView.bottomAnchor, multiplier: 1),
            progress.heightAnchor.constraint(equalToConstant: 5)
        ])
    }
    
    @objc func didTapApp(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progress.progress = 0.0
        secoundsPassed = 0
        label.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secoundsPassed < totalTime {
            secoundsPassed += 1
            progress.progress = Float(secoundsPassed) / Float(totalTime)
            print(Float(secoundsPassed) / Float(totalTime))
        }else {
            timer.invalidate()
            label.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
