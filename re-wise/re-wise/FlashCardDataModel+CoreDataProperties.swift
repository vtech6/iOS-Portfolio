//
//  FlashCardDataModel+CoreDataProperties.swift
//  re-wise
//
//  Created by Mikolaj Witkowski on 12/05/2020.
//  Copyright © 2020 Mikolaj Witkowski. All rights reserved.
//
//

import Foundation
import CoreData


extension FlashCardDataModel: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashCardDataModel> {
        return NSFetchRequest<FlashCardDataModel>(entityName: "FlashCardDataModel")
    }

    @NSManaged public var question: String?
    @NSManaged public var answer: String?
    @NSManaged public var id: UUID?

}
