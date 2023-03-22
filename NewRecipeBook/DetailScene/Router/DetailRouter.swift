// 
//  DetailRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import UIKit

protocol DetailRoutingLogic {
    func dismiss()
    func navigateToCalculator()
}

protocol DetailDataPassing {
    var dataStore: DetailDataStore? { get }
}

class DetailRouter: DetailDataPassing {
    
    //MARK: - Properties
    
    var dataStore: DetailDataStore?
    weak var viewController: UIViewController?
}

extension DetailRouter: DetailRoutingLogic {
    
    //MARK: - Methods
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
    
    func navigateToCalculator() {
        viewController?.navigationController?.pushViewController(CalculatorViewController(), animated: true)
    }
}
