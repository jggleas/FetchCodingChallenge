//
//  DataManager.swift
//  FetchCodingChallenge
//
//  Created by Jacob Gleason on 10/17/23.
//

import CoreData

final class DataManager {
    // MARK: Variables
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DessertsGaloreDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error { fatalError("Loading data failed with error: \(String(describing: error))") }
        }
        return container
    }()
    
    // MARK: - Data Management Functions
    // MARK: Create
    func createIngredient(name: String, measurement: String) {
        guard ingredients(ingredient: .init(name: name, measurement: measurement)).isEmpty else { return }
        let ingredient = OwnedIngredient(context: persistentContainer.viewContext)
        ingredient.name = name
        ingredient.measurement = measurement
        save()
    }
    
    // MARK: Save
    private func save() {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            // TODO: Handle error
            fatalError("Saving updated data failed with error: \(String(describing: error))")
        }
    }
    
    // MARK: Retrieve
    func ingredients(ingredient: Ingredient? = nil) -> [OwnedIngredient] {
        let request: NSFetchRequest<OwnedIngredient> = OwnedIngredient.fetchRequest()
        if let ingredient {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                .init(format: "name == %@", ingredient.name),
                .init(format: "measurement == %@", ingredient.measurement)
            ])
        }
        var ingredients = [OwnedIngredient]()
        do {
            ingredients = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Fetching ingredients failed with error: \(String(describing: error))")
        }
        return ingredients
    }
    
    // MARK: Delete
    func deleteIngredient(_ ingredient: Ingredient) {
        if let ownedIngredient = ingredients(ingredient: ingredient).first {
            deleteIngredient(ownedIngredient)
        } else {
            print("No owned ingredient to delete")
        }
    }
    
    func deleteIngredient(_ ingredient: OwnedIngredient) {
        persistentContainer.viewContext.delete(ingredient)
        save()
    }
}
