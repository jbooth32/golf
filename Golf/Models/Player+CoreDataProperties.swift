//
//  Player+CoreDataProperties.swift
//  Golf
//
//  Created by Jared on 5/8/20.
//  Copyright © 2020 Jared. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String
    @NSManaged public var game: NSSet?
    @NSManaged public var games: Int16
    @NSManaged public var score: Int16
    @NSManaged public var holes: Int16
    @NSManaged public var wins: Int16
    @NSManaged public var losses: Int16
    @NSManaged public var fin: Int16
    @NSManaged public var lows: [Int16]

}

// MARK: Generated accessors for game
extension Player {

    @objc(addGameObject:)
    @NSManaged public func addToGame(_ value: Game)

    @objc(removeGameObject:)
    @NSManaged public func removeFromGame(_ value: Game)

    @objc(addGame:)
    @NSManaged public func addToGame(_ values: NSSet)

    @objc(removeGame:)
    @NSManaged public func removeFromGame(_ values: NSSet)

}
