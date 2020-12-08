//
//  Mission+CoreDataProperties.swift
//  Tear
//
//  Created by Pedro Moura on 08/12/20.
//
//

import Foundation
import CoreData


extension Mission {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mission> {
        return NSFetchRequest<Mission>(entityName: "Mission")
    }

    @NSManaged public var modalText: String?
    @NSManaged public var modalTitle: String?
    @NSManaged public var progressEarned: Float
    @NSManaged public var badge: Badge?
    @NSManaged public var city: City?

}

extension Mission : Identifiable {

}
