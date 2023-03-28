//
//  CoreDataManager.swift
//  NewRecipeBook
//
//  Created by Pavel Schulepov on 12.01.2023.
//

import CoreData

class CoreDataManager {
    
    //MARK: - Properties
    
    static let execute = CoreDataManager()
    private let coreDataStack = CoreDataStack()
    
    //MARK: - Get all data
    
    func getAllDataTask<T: NSManagedObject>(completion: @escaping (Result<[T]?, Error>) -> Void) {
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest = T.fetchRequest()
        
        do {
            let data = try context.fetch(fetchRequest) as? [T]
            completion(.success(data))
            print("ExportCoreData DONE")
        } catch {
            completion(.failure(error))
            print("ExportCoreData ERROR")
        }
    }
    
    //MARK: - Save new recipe
    
    func saveDataTask(data: AddDescriptionModels.SaveData.Request) {
        let context = coreDataStack.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Recipe", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context) as? Recipe
        object?.name = data.name
        object?.category = data.category
        object?.image = data.imageData
        object?.ingredients = data.ingredients
        object?.descriptions = data.description
        object?.isFavorite = false
        object?.dateId = currentDate()
        
        do {
            try context.save()
            print("CoreDataSave DONE")
        } catch {
            print("CoreDataSave ERROR")
        }
    }
    
    //MARK: - Save to favorite
    
    func tapToFavoriteTask(id: String?, favorite: Bool?) {
        guard let id = id,
        let favorite = favorite else { return }
        var allRecipe = [Recipe]()
        let coreDataStack = CoreDataStack()
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let predicate = NSPredicate(format: "dateId == %@", id)
        fetchRequest.predicate = predicate
        
        do {
            print("Export CoreData Favorite DONE")
            allRecipe = try context.fetch(fetchRequest)
        } catch {
            print("Export CoreData Favorite ERROR")
        }
        
        let object = allRecipe[0] as NSManagedObject
        object.setValue(favorite, forKey: "isFavorite")

        do {
            try context.save()
            print("SAVE FAVORITE")
        } catch {
            print("EDIT FAVORITE ERROR")
        }
    }
    
    //MARK: - Delete recipe
    
    func deleteTask(id: String?) {
        guard let id = id else { return }
        let context = coreDataStack.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        let predicate = NSPredicate(format: "dateId == %@", id)
        fetchRequest.predicate = predicate
        do {
            let allRecipe = try context.fetch(fetchRequest)
            context.delete(allRecipe[0])
            try context.save()
            print("DELETE DONE")
        } catch {
            print("DELETE ERROR")
        }
    }
    
    //MARK: - Support date formatter
    
    private func currentDate() -> String {
        let date = NSDate().description
        let format = DateFormatter()
        format.date(from: date)
        format.dateFormat = "dd.MM.YY'T'HH:mm:ss"
        let returnDate = format.string(from: Date.init())
        return returnDate
    }
}
