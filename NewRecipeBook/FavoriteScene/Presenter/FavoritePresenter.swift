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
        let formattedRecipes = data.recipes?.map ({ recipe in
            FavoriteModels.FecthData.ViewModel.FormattedRecipe(name: recipe.name, image: recipe.image)
        }) ?? [FavoriteModels.FecthData.ViewModel.FormattedRecipe]()
        
        viewController?.displaying(data: FavoriteModels.FecthData.ViewModel(displayRecipes: formattedRecipes))
    }
}
