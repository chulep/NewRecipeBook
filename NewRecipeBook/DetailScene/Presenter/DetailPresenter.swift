// 
//  DetailPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import Foundation

protocol DetailPresentationLogic {
    func presentData(data: DetailModels.FecthData.Response)
}

class DetailPresenter {
    weak var viewController: DetailDisplayLogic?
}

extension DetailPresenter: DetailPresentationLogic {
    
    //MARK: - Presented Method
    
    func presentData(data: DetailModels.FecthData.Response) {
        let viewModel = DetailModels.FecthData.ViewModel(name: data.recipe.name, image: data.recipe.image, ingredients: data.recipe.ingredients, description: data.recipe.descriptions, isFavorite: data.recipe.isFavorite)
        viewController?.displaying(data: viewModel)
    }

}
