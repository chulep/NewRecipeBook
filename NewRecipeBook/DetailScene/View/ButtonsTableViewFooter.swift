//
//  ButtonsTableViewFooter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import UIKit

class ButtonsTableViewFooter: UITableViewHeaderFooterView {
    
    static let identifire = "basketFooter"
    
    //MARK: - UI Elements

    private let basketButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "cart"), for: .normal)
        $0.setTitle(NameHelper.DetailScene.basketButtonText, for: .normal)
        $0.backgroundColor = ColorHelper.orange
        $0.layer.cornerRadius = ConstantHelper.radius
        $0.addTarget(nil, action: #selector(DetailViewController.tapToBasket(_:)), for: .touchUpInside)
        $0.tintColor = ColorHelper.white
        return $0
    }(UIButton())
    
    private let calculatorButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "square.grid.3x3"), for: .normal)
        $0.setTitle(NameHelper.DetailScene.calculatorButtonText, for: .normal)
        $0.backgroundColor = ColorHelper.orange
        $0.layer.cornerRadius = ConstantHelper.radius
        $0.addTarget(nil, action: #selector(DetailViewController.tapToCalculator), for: .touchUpInside)
        $0.tintColor = ColorHelper.white
        return $0
    }(UIButton())
    
    //MARK: - LayoutSubviews
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createUI()
    }
    
    //MARK: - Create UI
    
    private func createUI() {
        addSubview(basketButton)
        addSubview(calculatorButton)

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
