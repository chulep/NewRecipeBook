//
//  BookPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

protocol BookPresentationLogic {
    func present(data: BookModels.FecthData.Response)
}

final class BookPresenter: BookPresentationLogic {

    weak var viewController: BookDisplayLogic?
    
    //MARK: - Present Method

    func present(data: BookModels.FecthData.Response) {
        let formattedRecipes = data.recipes?.map({ recipe in
            BookModels.FecthData.ViewModel.FormattedRecipe(name: recipe.name, image: recipe.image)
        }) ?? [BookModels.FecthData.ViewModel.FormattedRecipe]()
        
        viewController?.displaying(data: BookModels.FecthData.ViewModel(displayRecipes: formattedRecipes))
    }
}
