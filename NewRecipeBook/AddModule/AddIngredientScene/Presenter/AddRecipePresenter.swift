//
//  AddRecipePresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

protocol AddIngredientPresentationLogic {
    func presentData(data: AddIngredientModels.FetchData.Response)
}

final class AddIngredientPresenter: AddIngredientPresentationLogic {
    
    weak var viewController: AddIngredientDisplayLigic?
    
    //MARK: - Present Method
    
    func presentData(data: AddIngredientModels.FetchData.Response) {
        viewController?.displaying(data: AddIngredientModels.FetchData.ViewModel(ingredients: data.ingredients))
    }
}
