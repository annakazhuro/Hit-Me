//
//  ViewController.swift
//  BullsEye
//
//  Created by Anna Kazhuro on 4/5/19.
//  Copyright © 2019 Anna Kazhuro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // - Data
    var currentValue: Int = 0
    var targetValue = 0
    var scoreValue = 0
    var roundValue = 0
    
    // - UI
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var target: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var round: UILabel!
    
    // - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

//MARK: -
//MARK: - Actions

extension ViewController {

    @IBAction func startOver() {
        newGame()
    }
    
    @IBAction func showGreeting(_ sender: UIButton) {
        showAlert()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        currentValue = Int(slider.value.rounded())
    }
    
}

//MARK: -
//MARK: - Game Logic

extension ViewController {
    
    func startNewRound() {
        currentValue = 50
        targetValue = Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        roundValue += 1
        updateLabels()
    }
    
    func newGame() {
        roundValue = 0
        scoreValue = 0
        startNewRound()
    }
    
    func updateLabels() {
        target.text = String(targetValue)
        score.text = String(scoreValue)
        round.text = String(roundValue)
    }
    
    func showAlert() {
        let difference = abs(targetValue - currentValue)
        var point = 100 - difference
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
            point += 100
        } else if difference < 5 {
            title = "You almost there!"
            if difference == 1 {
                point += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        let message = "You scored \(point) points!"
        scoreValue += point
        
        let alert = UIAlertController (title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction (title: "OK", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

//MARK: -
//MARK: - Configure

extension ViewController {
    
    func configure() {
        configureSliderImage()
        configureStartValues()
    }
    
    func configureSliderImage() {
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlited = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlited, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    
    func configureStartValues() {
        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)
        startOver()
    }
    
}
