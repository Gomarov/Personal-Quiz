//
//  QuestionViewController.swift
//  Personal Quiz
//
//  Created by Павел on 29.05.2020.
//  Copyright © 2020 Павел. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    //MARK: - IB Outlets
    
    @IBOutlet var questionLabel: UILabel!

    @IBOutlet var singleStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet var multipleStackView: UIStackView!
    
    @IBOutlet var multipleLabels: [UILabel]!
    
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var rangedLabels: [UILabel]!
    
    @IBOutlet var rangedSlider: UISlider!
    
    @IBOutlet var questionProgressView: UIProgressView!
    
    //MARK: - Private Properties
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var answersChoosen: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    //MARK: - IB Actions
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        let currentAnswers = questions[questionIndex].answers
        guard let currentIndex = singleButtons.firstIndex(of: sender) else { return }
        let currentAnswer = currentAnswers[currentIndex]
        answersChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answersChoosen.append(answer)
            }
        }
        nextQuestion()
    }
    
    @IBAction func rangedAnswersButtonPressed() {
        let currentAnswers = questions[questionIndex].answers
        let index = Int(round(rangedSlider.value * Float(currentAnswers.count - 1)))
        answersChoosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    //MARK: - Private Methods
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        //get current question
        let currentQuestion = questions[questionIndex]
        
        //set current question
        questionLabel.text = currentQuestion.text
        
        // set progress for questions
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        questionProgressView.setProgress(totalProgress, animated: true)
        
        //sat navigation title
        title = "Вопрос №\(questionIndex + 1) из \(questions.count)"
        
        let currentAnswers = currentQuestion.answers
        
        //show stack view corresponding to question type
        switch currentQuestion.type {
        case .single:
            updateSingleStackView(using: currentAnswers)
        case .multiple:
           updateMultipleStackView(using: currentAnswers)
        case .ranged:
            updateRangedStackView(using: currentAnswers)
        }
    }
    
    /// Setup single stack view
    /// - Parameter answers: - array with answers
    ///
    /// Description of method
    private func updateSingleStackView(using answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    /// Setup multiple stack view
    /// - Parameter answers: - array with answers
    private func updateMultipleStackView(using answers: [Answer]) {
           multipleStackView.isHidden = false
        
        for (label,answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    /// Setup ranged stack view
    /// - Parameter answers: - array with answers
    private func updateRangedStackView(using answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    
    // MARK: - Navigation
    //show the next question or go to the next screen
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
        } else {
            performSegue(withIdentifier: "resultSegue", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "resultSegue" else { return }
        let resultVC = segue.destination as! ResultsViewController
        resultVC.responses = answersChoosen
        
    }
    
}
