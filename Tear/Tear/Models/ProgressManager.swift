//
//  ProgressManager.swift
//  Tear
//
//  Created by Pedro Moura on 10/12/20.
//

import CoreData

struct ProgressManager {
    static let shared = ProgressManager()
    static var context = DatabaseController.persistentContainer.viewContext
    
    func create(air: Float, water: Float, soil: Float, total: Float, name: String) -> Progress? {

        let progressObject = NSEntityDescription.insertNewObject(forEntityName: "Progress", into: ProgressManager.context)

        guard let progress =  progressObject as? Progress else {
            fatalError("Could not find Progress class")
        }

        progress.air = air
        progress.water = water
        progress.soil = soil
        progress.total = total
        progress.name = name

        return self.save() ? progress : nil
    }

    func get(name: String) -> Progress? {

        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let progress = try ProgressManager.context.fetch(fetchRequest)
            if !progress.isEmpty { return progress[0] }
        } catch let error {
            print("We Couldn't find the progress. \n \(error)")
        }

        return nil
    }

    func count() -> Int {

        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")

        do {
            return try ProgressManager.context.count(for: fetchRequest)
        } catch {
            return 0
        }
    }

    func getAll() -> [Progress]? {

        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")

        do {
            let progresss = try ProgressManager.context.fetch(fetchRequest)
            return progresss
        } catch {
            print("Something happened try again later.")
        }

        return nil
    }

    func delete(name: String) -> Bool {

        let fetchRequest = NSFetchRequest<Progress>(entityName: "Progress")

        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let progress = try ProgressManager.context.fetch(fetchRequest)

            if !progress.isEmpty {
                ProgressManager.context.delete(progress[0])
                return self.save()
            } else {
                print("This progress could not be found")
            }

        } catch {
            print("Error")
        }

        return false
    }

    func save() -> Bool {

        do {
            try ProgressManager.context.save()
            return true
        } catch let error {
            print("Sorry, we can't save the progress. Try again later. \n \(error)")
        }

        return false
    }
}

