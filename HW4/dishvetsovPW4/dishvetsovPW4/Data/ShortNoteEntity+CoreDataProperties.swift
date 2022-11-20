//
//  ShortNoteEntity+CoreDataProperties.swift
//  dishvetsovPW4
//
//  Created by Danil Shvetsov on 20.11.2022.
//
//

import Foundation
import CoreData

extension ShortNoteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ShortNoteEntity> {
        return NSFetchRequest<ShortNoteEntity>(entityName: "ShortNoteEntity")
    }

    @NSManaged public var text: String?

}

extension ShortNoteEntity : Identifiable { }
