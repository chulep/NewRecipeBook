//
//  ButtonsTableViewFooter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import UIKit

class ButtonsTableViewFooter: UITableViewHeaderFooterView {
    
    static let identifire = "basketFooter"

    let basketButton = UIButton()
    let calculatorButton = UIButton()
    let backgroundWhiteView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    func createUI() {
        
        addSubview(basketButton)
        basketButton.translatesAutoresizingMaskIntoConstraints = false
        basketButton.setImage(UIImage(systemName: "cart"), for: .normal)
        basketButton.setTitle(" В корзину", for: .normal)
        basketButton.backgroundColor = ColorHelper.orange
        basketButton.layer.cornerRadius = ConstantHelper.radius
        basketButton.addTarget(nil, action: #selector(DetailViewController.tapToBasket), for: .touchUpInside)
        
        addSubview(calculatorButton)
        calculatorButton.translatesAutoresizingMaskIntoConstraints = false
        calculatorButton.setImage(UIImage(systemName: "square.grid.3x3"), for: .normal)
        calculatorButton.setTitle(" Калькулятор", for: .normal)
        calculatorButton.backgroundColor = ColorHelper.orange
        calculatorButton.layer.cornerRadius = ConstantHelper.radius
        calculatorButton.addTarget(nil, action: #selector(DetailViewController.tapToCalculator), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            basketButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            basketButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            basketButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            basketButton.widthAnchor.constraint(equalToConstant: bounds.width / 2 - 25),
            
            calculatorButton.leftAnchor.constraint(equalTo: basketButton.rightAnchor, constant: 10),
            calculatorButton.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            calculatorButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            calculatorButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
