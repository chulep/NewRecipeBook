//
//  NewIngredientViewController.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 09.02.2023.
//

import UIKit

final class NewIngredientViewController: UIViewController {
    
    weak var delegate: TextTransferDelegate?
    
    //MARK: - UI Elements
    
    private let nameTextField: UITextField = {
        $0.textAlignment = .center
        $0.placeholder = NameHelper.AddModule.IngredientScene.NewIngredientView.nameTextFieldPlaceholderText
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorHelper.gray.cgColor
        return $0
    }(UITextField())
    
    private let weightTextField: UITextField = {
        $0.textAlignment = .center
        $0.placeholder = NameHelper.AddModule.IngredientScene.NewIngredientView.weightTextFieldPlaceholderText
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorHelper.gray.cgColor
        $0.keyboardType = .numberPad
        return $0
    }(UITextField())
    
    private let measureSegment: UISegmentedControl = {
        $0.selectedSegmentIndex = 0
        return $0
    }(UISegmentedControl(items: NameHelper.AddModule.IngredientScene.NewIngredientView.measureSegmentNames))
    
    private let confirmButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = ColorHelper.orange
        $0.addTarget(nil, action: #selector(tapToConfirm), for: .touchUpInside)
        $0.setTitle(NameHelper.AddModule.IngredientScene.NewIngredientView.addButtonText, for: .normal)
        $0.layer.cornerRadius = ConstantHelper.radius
        return $0
    }(UIButton())
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        createUI()
        setupNavBar()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        view.addSubview(confirmButton)
        
        for i in [nameTextField, weightTextField, measureSegment] {
            view.addSubview(i)
            i.translatesAutoresizingMaskIntoConstraints = false
            i.backgroundColor = ColorHelper.babackgroundGrey
            i.layer.cornerRadius = ConstantHelper.radius
        }
        
        let smallWidth = view.bounds.width / 3
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            weightTextField.leftAnchor.constraint(equalTo: nameTextField.leftAnchor),
            weightTextField.widthAnchor.constraint(equalToConstant: smallWidth - 25),
            weightTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            measureSegment.centerYAnchor.constraint(equalTo: weightTextField.centerYAnchor),
            measureSegment.rightAnchor.constraint(equalTo: nameTextField.rightAnchor),
            measureSegment.widthAnchor.constraint(equalToConstant: smallWidth * 2 - 25),
            measureSegment.heightAnchor.constraint(equalTo: weightTextField.heightAnchor),
            
            confirmButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 50),
            confirmButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            confirmButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -5)
        ])
    }
    
    private func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: NameHelper.AddModule.IngredientScene.NewIngredientView.cancelButtonText, image: nil, target: self, action: #selector(tapToCancel))
    }
    
    //MARK: - Action Methods
    
    @objc func tapToCancel() {
        dismiss(animated: true)
    }
    
    @objc func tapToConfirm() {
        if nameTextField.text == "" || weightTextField.text == "" {
            nameTextField.center.x += 5
            weightTextField.center.x += 5
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0) {
                self.nameTextField.center.x -= 5
                self.weightTextField.center.x -= 5
            }
        } else {
            delegate?.addNewSector(text: createText())
            dismiss(animated: true)
        }
    }
    
    //MARK: - Support Methods
    
    private func createText() -> String {
        guard let nameText = nameTextField.text,
              let weightText = weightTextField.text else { return "Ошибка сохранения" }
        let baseText = nameText + " - " + weightText
        
        switch measureSegment.selectedSegmentIndex {
        case 0:
            return baseText + " гр."
        case 1:
            return baseText + " шт."
        case 2:
            return baseText + " мл."
        case 3:
            return baseText + " ст.л."
        case 4:
            return baseText + " ч.л."
        default:
            return "Ошибка сохранения"
        }
    }
}
