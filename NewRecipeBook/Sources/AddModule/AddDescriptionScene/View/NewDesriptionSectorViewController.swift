// 
//  NewDesriptionSectorViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import UIKit

final class NewDesriptionSectorViewController: UIViewController {
    
    weak var textTransferDelegate: TextTransferDelegate?
    
    private var maxHeight: CGFloat = 50
    private var isOversized = false {
        didSet {
            textView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -5).isActive = true
            textView.setNeedsUpdateConstraints()
            textView.isScrollEnabled = isOversized
        }
    }
    
    //MARK: - UI Elements
    
    private var confirmButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle(NameHelper.AddModule.DescriptionScene.NewDescriptionView.addButtonText, for: .normal)
        $0.backgroundColor = ColorHelper.orange
        $0.addTarget(nil, action: #selector(addContinue), for: .touchUpInside)
        $0.layer.cornerRadius = ConstantHelper.radius
        return $0
    }(UIButton())
    
    private var textView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isScrollEnabled = false
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorHelper.gray.cgColor
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.backgroundColor = ColorHelper.babackgroundGrey
        $0.layer.cornerRadius = ConstantHelper.radius
        return $0
    }(UITextView())
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        setupNavBar()
        textView.delegate = self
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        view.backgroundColor = .white
        
        view.addSubview(confirmButton)
        view.addSubview(textView)
        
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        textView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        NSLayoutConstraint.activate([
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            confirmButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -5),
        ])
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NameHelper.AddModule.DescriptionScene.NewDescriptionView.cancelButtonText, image: nil, target: self, action: #selector(tapToCancel))
    }
    
    //MARK: - Action Methods
    
    @objc private func tapToCancel() {
        dismiss(animated: true)
    }
    
    @objc private func addContinue() {
        if textView.text != "" {
            textTransferDelegate?.addNewSector(text: textView.text)
        }
        dismiss(animated: true)
    }
}

//MARK: - TextView Delegate

extension NewDesriptionSectorViewController: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height >= maxHeight {
            isOversized = true
        }
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        maxHeight = confirmButton.frame.origin.y - 100
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}
