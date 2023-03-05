// 
//  AddDescriptionSceneRouter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 08.01.2023.
//

import UIKit

protocol AddDescriptionRoutingLogic {
    func dismissScene()
}

protocol AddDescriptionDataPassing {
    var dataStore: AddDescriptionDataStore? { get }
}

class AddDescriptionRouter: AddDescriptionDataPassing {
    
    //MARK: - Properties
    
    var dataStore: AddDescriptionDataStore?
    weak var viewController: UIViewController?
}

extension AddDescriptionRouter: AddDescriptionRoutingLogic {
    
    //MARK: - Navigate methods
    
    func dismissScene() {
        viewController?.dismiss(animated: true)
    }
}
