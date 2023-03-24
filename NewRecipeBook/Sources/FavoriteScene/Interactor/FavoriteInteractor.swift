// 
//  FavoriteInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 02.02.2023.
//

import Foundation

protocol FavoriteBusinessLogic {
    func fetchData()
}

protocol FavoriteDataStore {
    var recipes: [Recipe]? { get set }
}

class FavoriteInteractor: FavoriteBusinessLogic, FavoriteDataStore {
    
    var presenter: FavoritePresentationLogic?
    var recipes: [Recipe]?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        CoreDataManager.execute.getAllDataTask { (result: Result<[Recipe]?, Error>) in
            switch result {
            case .success(let data):
                self.recipes = data?.filter { $0.isFavorite == true }
            case .failure(_):
                break
            }
        }
        presenter?.presentData(data: FavoriteModels.FecthData.Response(recipes: recipes))
    }
}
