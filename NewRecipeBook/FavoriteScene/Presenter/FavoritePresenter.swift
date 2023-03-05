// 
//  FavoritePresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.02.2023.
//

import Foundation

protocol FavoritePresentationLogic {
    func presentData(data: FavoriteModels.FecthData.Response)
}

class FavoritePresenter {
    weak var viewController: FavoriteDisplayLogic?
}

extension FavoritePresenter: FavoritePresentationLogic {
    
    //MARK: - Presented Method
    
    func presentData(data: FavoriteModels.FecthData.Response) {
        var formattedRecipes = [FavoriteModels.FecthData.ViewModel.FormattedRecipe]()
        guard let recipes = data.recipes else { viewController?.displaying(data: FavoriteModels.FecthData.ViewModel(displayRecipes: formattedRecipes)); return }
        for i in recipes {
            formattedRecipes.append(FavoriteModels.FecthData.ViewModel.FormattedRecipe(name: i.name, image: i.image))
        }
        viewController?.displaying(data: FavoriteModels.FecthData.ViewModel(displayRecipes: formattedRecipes))
    }

}
