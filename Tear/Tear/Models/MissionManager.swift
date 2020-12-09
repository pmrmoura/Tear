import CoreData

struct MissionManager {
    static let shared = MissionManager()
    static var context = DatabaseController.persistentContainer.viewContext
    
    func create(modalText: String, modalTitle: String, progressEarned: Float, badge: Badge?) -> Mission? {

        let missionObject = NSEntityDescription.insertNewObject(forEntityName: "Mission", into: MissionManager.context)

        guard let mission =  missionObject as? Mission else {
            fatalError("Could not find Mission class")
        }

        mission.modalText = modalText
        mission.modalTitle = modalTitle
        mission.progressEarned = progressEarned
        mission.badge = badge

        return self.save() ? mission : nil
    }

    func get(badgeName: String) -> Mission? {

        let fetchRequest = NSFetchRequest<Mission>(entityName: "Mission")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "badge.name == %@", badgeName)

        do {
            let mission = try MissionManager.context.fetch(fetchRequest)
            if !mission.isEmpty { return mission[0] }
        } catch let error {
            print("We Couldn't find the mission. \n \(error)")
        }

        return nil
    }

    func count() -> Int {

        let fetchRequest = NSFetchRequest<Mission>(entityName: "Mission")

        do {
            return try MissionManager.context.count(for: fetchRequest)
        } catch {
            return 0
        }
    }

    func getAll() -> [Mission]? {

        let fetchRequest = NSFetchRequest<Mission>(entityName: "Mission")

        do {
            let missions = try MissionManager.context.fetch(fetchRequest)
            return missions
        } catch {
            print("Something happened try again later.")
        }

        return nil
    }

    func delete(name: String) -> Bool {

        let fetchRequest = NSFetchRequest<Mission>(entityName: "Mission")

        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let mission = try MissionManager.context.fetch(fetchRequest)

            if !mission.isEmpty {
                MissionManager.context.delete(mission[0])
                return self.save()
            } else {
                print("This mission could not be found")
            }

        } catch {
            print("Error")
        }

        return false
    }

    func save() -> Bool {

        do {
            try MissionManager.context.save()
            return true
        } catch let error {
            print("Sorry, we can't save the mission. Try again later. \n \(error)")
        }

        return false
    }
}
