//
//  InputCalculatorView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import UIKit

class InputCalculatorView: UIView {
    
    //MARK: - UI Elements
    
    let inputTextField: UITextField = {
        $0.backgroundColor = ColorHelper.babackgroundGrey
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = .center
        $0.keyboardType = .numberPad
        $0.becomeFirstResponder()
        $0.addTarget(nil, action: #selector(CalculatorViewController.editInput(_:)), for: .allEditingEvents)
        return $0
    }(UITextField())
    
    let supportLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = ColorHelper.lightGray
        return $0
    }(UILabel())
    
    //MARK: - Init
    
    convenience init(title: String) {
        self.init()
        supportLabel.text = title
    }
    
    //MARK: - LayoutSubviews

    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI

    private func createUI() {
        layer.cornerRadius = ConstantHelper.radius
        clipsToBounds = true
        backgroundColor = ColorHelper.lightGray
        
        addSubview(inputTextField)
        addSubview(supportLabel)
        
        NSLayoutConstraint.activate([
            inputTextField.topAnchor.constraint(equalTo: topAnchor),
            inputTextField.leftAnchor.constraint(equalTo: leftAnchor),
            inputTextField.rightAnchor.constraint(equalTo: rightAnchor),
            inputTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3),
            
            supportLabel.topAnchor.constraint(equalTo: inputTextField.bottomAnchor),
            supportLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
            supportLabel.rightAnchor.constraint(equalTo: rightAnchor),
            supportLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
