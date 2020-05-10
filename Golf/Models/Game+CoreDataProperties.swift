//
//  Game+CoreDataProperties.swift
//  Golf
//
//  Created by Jared on 5/8/20.
//  Copyright © 2020 Jared. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var bonus: Int16
    @NSManaged public var box: [[Int]]?
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var holes: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var players: [String]?
    @NSManaged public var player: NSSet?

}

// MARK: Generated accessors for player
extension Game {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: Player)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: Player)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}
