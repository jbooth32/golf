//
//  Hole+CoreDataProperties.swift
//  Golf
//
//  Created by Jared on 5/8/20.
//  Copyright © 2020 Jared. All rights reserved.
//
//

import Foundation
import CoreData


extension Hole {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hole> {
        return NSFetchRequest<Hole>(entityName: "Hole")
    }

    @NSManaged public var finish: Int16
    @NSManaged public var name: String?
    @NSManaged public var start: Int16
    @NSManaged public var stats: [String:[String:Int]]?

}
