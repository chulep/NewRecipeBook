//
//  supportView.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import UIKit

class ResultCalculatorView: UIView {
    
    //MARK: - UI Elements
    
    let resultLabel: UILabel = {
        $0.backgroundColor = ColorHelper.babackgroundGrey
        $0.text = "0"
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
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
        
        addSubview(resultLabel)
        addSubview(supportLabel)
        
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: topAnchor),
            resultLabel.leftAnchor.constraint(equalTo: leftAnchor),
            resultLabel.rightAnchor.constraint(equalTo: rightAnchor),
            resultLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3),
            
            supportLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor),
            supportLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 3),
            supportLabel.rightAnchor.constraint(equalTo: rightAnchor),
            supportLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: - Set Data
    
    func setData(result: String) {
        resultLabel.text = result
    }
}
