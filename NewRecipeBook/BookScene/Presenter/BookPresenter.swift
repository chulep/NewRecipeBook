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
        var formattedRecipes = [BookModels.FecthData.ViewModel.FormattedRecipe]()
        guard let recipes = data.recipes else { viewController?.displaying(data: BookModels.FecthData.ViewModel(displayRecipes: formattedRecipes)); return }
        for i in recipes {
            let formattedRecipe = BookModels.FecthData.ViewModel.FormattedRecipe(name: i.name, image: i.image)
            formattedRecipes.append(formattedRecipe)
        }
        viewController?.displaying(data: BookModels.FecthData.ViewModel(displayRecipes: formattedRecipes))
    }
}
