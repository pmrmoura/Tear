//
//  Badge+CoreDataProperties.swift
//  Tear
//
//  Created by Pedro Moura on 08/12/20.
//
//

import Foundation
import CoreData


extension Badge {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Badge> {
        return NSFetchRequest<Badge>(entityName: "Badge")
    }

    @NSManaged public var explainText: String?
    @NSManaged public var imageName: String?
    @NSManaged public var link: URL?
    @NSManaged public var name: String?

}

extension Badge : Identifiable {

}
