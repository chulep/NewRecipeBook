// 
//  BasketRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 03.02.2023.
//

import UIKit

protocol BasketRoutingLogic {
    func navigateToNextScene()
}

protocol BasketDataPassing {
    var dataStore: BasketDataStore? { get }
}

class BasketRouter: BasketDataPassing {
    
    var dataStore: BasketDataStore?
    weak var viewController: UIViewController?
}

extension BasketRouter: BasketRoutingLogic {

    func navigateToNextScene() {
        //viewController?.present(nextViewController, animated: true)
    }
}