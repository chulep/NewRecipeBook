//
//  AddRecipePresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

protocol AddIngredientPresentationLogic {
    func presentData(model: AddIngredientModels.FetchData.Response)
}

final class AddIngredientPresenter: AddIngredientPresentationLogic {
    
    weak var viewController: AddIngredientDisplayLigic?
    
    //MARK: - Present Method
    
    func presentData(model: AddIngredientModels.FetchData.Response) {
        let viewModel = AddIngredientModels.FetchData.ViewModel(ingredients: model.ingredients)
        viewController?.displaying(viewModel: viewModel)
    }
}
