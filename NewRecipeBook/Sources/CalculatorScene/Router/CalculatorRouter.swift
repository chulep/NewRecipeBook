// 
//  CalculatorRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.02.2023.
//

import UIKit

protocol CalculatorRoutingLogic {
    func navigateToNextScene()
}

protocol CalculatorDataPassing {
    var dataStore: CalculatorDataStore? { get }
}

class CalculatorRouter: CalculatorDataPassing {
    
    var dataStore: CalculatorDataStore?
    weak var viewController: UIViewController?
}

extension CalculatorRouter: CalculatorRoutingLogic {

    func navigateToNextScene() {
        //viewController?.present(nextViewController, animated: true)
    }
}