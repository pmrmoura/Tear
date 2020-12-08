//
//  City+CoreDataProperties.swift
//  Tear
//
//  Created by Pedro Moura on 08/12/20.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var badgesEarned: NSSet?
    @NSManaged public var relationship: NSSet?
    @NSManaged public var relationship1: Progress?

}

// MARK: Generated accessors for badgesEarned
extension City {

    @objc(addBadgesEarnedObject:)
    @NSManaged public func addToBadgesEarned(_ value: Badge)

    @objc(removeBadgesEarnedObject:)
    @NSManaged public func removeFromBadgesEarned(_ value: Badge)

    @objc(addBadgesEarned:)
    @NSManaged public func addToBadgesEarned(_ values: NSSet)

    @objc(removeBadgesEarned:)
    @NSManaged public func removeFromBadgesEarned(_ values: NSSet)

}

// MARK: Generated accessors for relationship
extension City {

    @objc(addRelationshipObject:)
    @NSManaged public func addToRelationship(_ value: Mission)

    @objc(removeRelationshipObject:)
    @NSManaged public func removeFromRelationship(_ value: Mission)

    @objc(addRelationship:)
    @NSManaged public func addToRelationship(_ values: NSSet)

    @objc(removeRelationship:)
    @NSManaged public func removeFromRelationship(_ values: NSSet)

}

extension City : Identifiable {

}
