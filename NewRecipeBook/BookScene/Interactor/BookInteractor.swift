//
//  BookInteractor.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 05.01.2023.
//

import Foundation

protocol BookBusinessLogic {
    func fetchData()
    func search(model: BookModels.FecthData.Request)
}

protocol BookDataStore {
    var data: [Recipe]? { get set }
}

final class BookInteractor: BookBusinessLogic, BookDataStore {
    
    //MARK: - Properties
    
    var presenter: BookPresentationLogic?
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
        presenter?.present(data: BookModels.FecthData.Response(recipes: data))
    }
    
    //MARK: - Search Data
    
    func search(model: BookModels.FecthData.Request) {
        let searchText = model.searchText ?? ""
        guard let dataFiltred = data?.filter({ return String($0.name ?? "").lowercased().contains(searchText.lowercased()) }) else { return }
        presenter?.present(data: BookModels.FecthData.Response(recipes: dataFiltred))
    }
}
