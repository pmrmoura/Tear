import CoreData

struct BadgeManager {
    static let shared = BadgeManager()
    static var context = DatabaseController.persistentContainer.viewContext
    
    func create(explainText: String, imageName: String, link: String, name: String, win: Bool) -> Badge? {

        let badgeObject = NSEntityDescription.insertNewObject(forEntityName: "Badge", into: BadgeManager.context)

        guard let badge =  badgeObject as? Badge else {
            fatalError("Could not find Badge class")
        }

        badge.explainText = explainText
        badge.imageName = imageName
        badge.link = URL(string: link)
        badge.name = name
        badge.win = win

        return self.save() ? badge : nil
    }

    func get(name: String) -> Badge? {

        let fetchRequest = NSFetchRequest<Badge>(entityName: "Badge")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "imageName == %@", name)

        do {
            let badge = try BadgeManager.context.fetch(fetchRequest)
            if !badge.isEmpty { return badge[0] }
        } catch let error {
            print("We Couldn't find the badge. \n \(error)")
        }

        return nil
    }

    func count() -> Int {

        let fetchRequest = NSFetchRequest<Badge>(entityName: "Badge")

        do {
            return try BadgeManager.context.count(for: fetchRequest)
        } catch {
            return 0
        }
    }

    func getAll() -> [Badge]? {

        let fetchRequest = NSFetchRequest<Badge>(entityName: "Badge")

        do {
            let badges = try BadgeManager.context.fetch(fetchRequest)
            return badges
        } catch {
            print("Something happened try again later.")
        }

        return nil
    }

    func delete(name: String) -> Bool {

        let fetchRequest = NSFetchRequest<Badge>(entityName: "Badge")

        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let badge = try BadgeManager.context.fetch(fetchRequest)

            if !badge.isEmpty {
                BadgeManager.context.delete(badge[0])
                return self.save()
            } else {
                print("This badge could not be found")
            }

        } catch {
            print("Error")
        }

        return false
    }

    func save() -> Bool {

        do {
            try BadgeManager.context.save()
            return true
        } catch let error {
            print("Sorry, we can't save the badge. Try again later. \n \(error)")
        }

        return false
    }
}
