//
//  Progress+CoreDataProperties.swift
//  Tear
//
//  Created by Pedro Moura on 08/12/20.
//
//

import Foundation
import CoreData


extension Progress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Progress> {
        return NSFetchRequest<Progress>(entityName: "Progress")
    }

    @NSManaged public var air: Float
    @NSManaged public var soil: Float
    @NSManaged public var total: Float
    @NSManaged public var water: Float
    @NSManaged public var city: City?

}

extension Progress : Identifiable {

}
