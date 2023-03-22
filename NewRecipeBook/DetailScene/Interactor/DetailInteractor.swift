// 
//  DetailInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 17.01.2023.
//

import Foundation

protocol DetailBusinessLogic {
    func fetchData()
    func addToFavorite()
    func saveBasket(ingredients: [String]?)
    func deleteRecipe()
}

protocol DetailDataStore {
    var data: Recipe? { get set }
}

class DetailInteractor: DetailBusinessLogic, DetailDataStore {
    
    //MARK: - Properties
    
    var presenter: DetailPresentationLogic?
    var data: Recipe?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        guard let recipe = data else { return }
        presenter?.presentData(data: DetailModels.FecthData.Response(recipe: recipe))
    }
    
    //MARK: - Save ingredients to Basket
    
    func saveBasket(ingredients: [String]?) {
        guard let ingredients = ingredients else { return }
        guard let basket: [String] = UserDefaults.standard.object(forKey: ConstantHelper.basketKey) as? [String] else {
            return UserDefaults.standard.set(ingredients, forKey: ConstantHelper.basketKey)
        }
        let fullBasketSave = basket + ingredients
        UserDefaults.standard.set(fullBasketSave, forKey: ConstantHelper.basketKey)
    }
    
    //MARK: - Add to Favorite
    
    func addToFavorite() {
        let isFavorite = data?.isFavorite ?? false
        data?.isFavorite = !isFavorite
        CoreDataManager.execute.tapToFavoriteTask(id: data?.dateId, favorite: !isFavorite)
        
        guard let recipe = data else { return }
        let presenterModel = DetailModels.FecthData.Response(recipe: recipe)
        presenter?.presentData(data: presenterModel)
    }
    
    //MARK: - Delete Recipe
    
    func deleteRecipe() {
        CoreDataManager.execute.deleteTask(id: data?.dateId)
    }
}
