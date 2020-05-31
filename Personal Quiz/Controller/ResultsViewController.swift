//
//  ResultsViewController.swift
//  Personal Quiz
//
//  Created by Павел on 29.05.2020.
//  Copyright © 2020 Павел. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var resultAnswerLabel: UILabel!
    @IBOutlet var resultDefinitionLabel: UILabel!
    
    //MARK: - Public properties
    var responses: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResult()
    }
    
    private func updateResult() {
        var frequencyOfAnimals: [AnimalType: Int] = [:]
        let animals = responses.map { $0.type }
        for animal in animals {
            frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequencyAnimal)
        
    }
    
    private func updateUI(with animal: AnimalType) {
        resultAnswerLabel.text = "Вы - \(animal.rawValue)"
        resultDefinitionLabel.text = "\(animal.definition)"
    }
}
