// 
//  SelectCategoryPresenter.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 21.01.2023.
//

import Foundation

protocol SelectCategoryPresentationLogic {
    func presentData(category: String?, data: SelectCategoryModels.FecthData.Response)
}

class SelectCategoryPresenter {
    weak var viewController: SelectCategoryDisplayLogic?
}

extension SelectCategoryPresenter: SelectCategoryPresentationLogic {
    
    //MARK: - Presented Method
    
    func presentData(category: String?, data: SelectCategoryModels.FecthData.Response) {
        var formattedRecipes = [SelectCategoryModels.FecthData.ViewModel.FormattedRecipe]()
        guard let recipes = filtredCategory(data: data.recipes, category: category)
        else { viewController?.displaying(category: category, data: SelectCategoryModels.FecthData.ViewModel(displayRecipes: formattedRecipes)); return }
        
        for i in recipes {
            let formattedRecipe = SelectCategoryModels.FecthData.ViewModel.FormattedRecipe(name: i.name, image: i.image)
            formattedRecipes.append(formattedRecipe)
        }
        
        viewController?.displaying(category: category, data: SelectCategoryModels.FecthData.ViewModel(displayRecipes: formattedRecipes))
    }
    
    //MARK: - Supprt Sorted Method
    
    private func filtredCategory(data: [Recipe]?, category: String?) -> [Recipe]? {
        guard let data = data,
              let category = category else { return nil }
        print(category)
        return data.filter { ($0.category!.contains(category)) }
    }
}
