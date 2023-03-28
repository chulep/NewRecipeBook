//
//  FavoriteWorker.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 03.02.2023.
//

import Foundation

class FavoriteWorker {
    
    func getData(completion: @escaping (Result<[FavoriteModels.FecthData.Response]?, Error>) -> Void) {
        CoreDataManager.execute.getFavorite { (result: Result<[Recipe]?, Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.map { $0.mapping } ))
            case .failure(let error):
                print(error)
            }
        }
    }
}
