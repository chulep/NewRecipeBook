// 
//  DetailRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import UIKit

protocol DetailRoutingLogic {
    func navigateToNextScene()
    func dismiss()
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

    func navigateToNextScene() {
        //viewController?.present(nextViewController, animated: true)
    }
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
