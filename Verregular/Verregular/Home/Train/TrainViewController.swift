//
//  TrainViewController.swift
//  Verregular
//
//  Created by pravda on 07.11.2023.
//

import UIKit
import SnapKit


final class TrainViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var infinitiveLabel: UILabel = {
        
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .black
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var verbCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "0/0"
        return label
    }()
    
    private lazy var scoreLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            label.textAlignment = .center
            label.text = "Score: 0"
            return label
    }()
    
    private lazy var pastSimpleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Simle"
        
        return label
    }()
    
    private lazy var participleLabel: UILabel = {
        
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.text = "Past Participle"
        
        return label
    }()
    
    private lazy var pastSimpleTextField: UITextField = {
       let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var participleTextField: UITextField = {
       let field = UITextField()
        
        field.borderStyle = .roundedRect
        field.delegate = self
        
        return field
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemGray5
        button.setTitle("Check".localized, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(checkAction), for: .touchUpInside)
        
        
        return button
    }()
    
    //MARK: - Properties
    private let edgeInsets = 30
    private let dataSource = IrregularVerbs.shared.selectedVerbs
    private var currentVerb: Verb? {
        guard dataSource.count > count else { return nil }
        dataSource[count]
        return dataSource[count]
    }
    
    private var count = 0 {
        didSet {
            infinitiveLabel.text = currentVerb?.infinitive
            pastSimpleTextField.text = ""
            participleTextField.text = ""
        }
    }
    
    private var userScore: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(userScore)"
            scoreLabel.font = .systemFont(ofSize: 16)
            scoreLabel.textColor = .systemGreen
            scoreLabel.textAlignment = .center
        }
    }
    //MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = "Score: \(userScore)"
        title = "Train verbs".localized
        setupUI()
        hideKeyboardWhenTappedAround()
        
        infinitiveLabel.text = dataSource.first?.infinitive
        updateVerbCountLabel()
        userScore = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        unregisterForKeyboardNotification()
    }
    
    //MARK: - Private methods
    @objc
    private func checkAction() {
        if checkAnswers() {
            count += 1
            userScore += 1
            updateVerbCountLabel()
            if count == dataSource.count {
                showScoreAlert()
                }
            } else {
            checkButton.backgroundColor = .systemGray5
            checkButton.setTitle("Try again", for: .normal)
            scoreLabel.textColor = .systemRed
        }
    }

    private func showScoreAlert() {
        let alertController = UIAlertController(title: "Training Completed",
                                                message: "Your score is \(userScore)",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    private func updateVerbCountLabel() {
        let currentCount = count + 1
        let totalCount = dataSource.count
        verbCountLabel.text = "\(currentCount)/\(totalCount)"
    }

    
    private func checkAnswers() -> Bool {
        pastSimpleTextField.text?.lowercased() == currentVerb?.pastSimple.lowercased() &&
        participleTextField.text?.lowercased() == currentVerb?.participle.lowercased()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubviews([infinitiveLabel,
                                verbCountLabel,
                                pastSimpleLabel,
                                pastSimpleTextField,
                                participleLabel,
                                participleTextField,
                                checkButton,
                                scoreLabel])
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.size.edges.equalToSuperview()
        }
        
        infinitiveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        verbCountLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleLabel.snp.makeConstraints { make in
            make.top.equalTo(infinitiveLabel.snp.bottom).offset(80)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        pastSimpleTextField.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleLabel.snp.bottom).offset(10)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        scoreLabel.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(15)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleLabel.snp.makeConstraints { make in
            make.top.equalTo(pastSimpleTextField.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        participleTextField.snp.makeConstraints { make in
            make.top.equalTo(participleLabel.snp.bottom).offset(20)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
        
        checkButton.snp.makeConstraints { make in
            make.top.equalTo(participleTextField.snp.bottom).offset(50)
            make.trailing.leading.equalToSuperview().inset(edgeInsets)
        }
    }
}

//MARK: - UITextFieldDelegate
extension TrainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if pastSimpleTextField.isFirstResponder {
            participleTextField.becomeFirstResponder()
        } else {
            scrollView.endEditing(true)
        } 
        
        return true
    }
}

//MARK: - Keyboard events
private extension TrainViewController {
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unregisterForKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(_ notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView.contentInset.bottom = frame.height + 50
    }
    
    @objc
    func keyboardWillHide() {
        scrollView.contentInset.bottom = .zero - 50
    }
    
    func hideKeyboardWhenTappedAround() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        scrollView.addGestureRecognizer(recognizer)
    }
    
    @objc
    func hideKeyboard() {
        scrollView.endEditing(true)
    }
}

