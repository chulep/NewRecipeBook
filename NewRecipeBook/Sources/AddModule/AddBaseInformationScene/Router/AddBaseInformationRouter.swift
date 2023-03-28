// 
//  AddBaseInformationRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 11.01.2023.
//

import UIKit

protocol AddBaseInformationRoutingLogic {
    func navigateToNextScene()
    func dismissScene()
}

protocol AddBaseInformationDataPassing {
    var dataStore: AddBaseInformationDataStore? { get }
}

class AddBaseInformationRouter: AddBaseInformationDataPassing {
    
    //MARK: - Properties
    
    var dataStore: AddBaseInformationDataStore?
    weak var viewController: UIViewController?
}

extension AddBaseInformationRouter: AddBaseInformationRoutingLogic {

    //MARK: - Methods
    
    func navigateToNextScene() {
        let ingredientVC = AddIngredientViewController()
        var nextDS = ingredientVC.router?.dataStore
        let homeDS = dataStore
        nextDS?.saveData = homeDS?.saveData
        viewController?.navigationController?.pushViewController(ingredientVC, animated: true)
    }
    
    func dismissScene() {
        viewController?.dismiss(animated: true)
    }
}
