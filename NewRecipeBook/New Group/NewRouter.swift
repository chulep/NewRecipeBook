// 
//  NewRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 06.01.2023.
//

import UIKit

protocol NewRoutingLogic {
    func navigateToNextScene()
}

protocol NewDataPassing {
    var dataStore: NewDataStore? { get }
}

class NewRouter: NewDataPassing {
    
    var dataStore: NewDataStore?
    weak var viewController: UIViewController?
}

extension NewRouter: NewRoutingLogic {

    func navigateToNextScene() {
        //viewController?.present(nextViewController, animated: true)
    }
}