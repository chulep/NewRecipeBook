//
//  AddRecipeRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import UIKit

protocol AddIngredientRoutingLogic {
    func tapToNextScreen()
}

protocol AddIngredientDataPassing {
    var dataStore: AddIngredientDataStore? { get }
}

final class AddIngredientRouter: AddIngredientRoutingLogic, AddIngredientDataPassing {
    
    //MARK: - Properties
    
    weak var viewController: UIViewController?
    var dataStore: AddIngredientDataStore?
    
    //MARK: - Navigate methods
    
    func tapToNextScreen() {
        let nextVC = AddDescriptionViewController()
        var nextDataStore = nextVC.router?.dataStore
        let mainDataStore = dataStore
        nextDataStore?.saveData = mainDataStore?.saveIngredientData
        viewController?.navigationController?.pushViewController(nextVC, animated: true)
    }
}
