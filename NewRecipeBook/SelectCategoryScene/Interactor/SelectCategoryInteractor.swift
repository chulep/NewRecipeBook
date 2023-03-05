// 
//  SelectCategoryInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 21.01.2023.
//

import Foundation

protocol SelectCategoryBusinessLogic {
    func fetchData()
}

protocol SelectCategoryDataStore {
    var category: String? { get set }
    var data: [Recipe]? { get set }
}

class SelectCategoryInteractor: SelectCategoryBusinessLogic, SelectCategoryDataStore {
    
    //MARK: - Properties
    
    var presenter: SelectCategoryPresentationLogic?
    var category: String?
    var data: [Recipe]?
    
    //MARK: - Fetch Data
    
    func fetchData() {
        CoreDataManager.execute.getAllDataTask { (result: Result<[Recipe]?, Error>) in
            switch result {
            case .success(let data):
                self.data = data
            case .failure(let error):
                print(error)
            }
        }
        presenter?.presentData(category: category, data: SelectCategoryModels.FecthData.Response(recipes: data))
    }
}
