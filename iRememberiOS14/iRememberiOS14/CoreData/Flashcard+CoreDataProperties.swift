//
//  Flashcard+CoreDataProperties.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 25/06/2020.
//
//

import Foundation
import CoreData


extension Flashcard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Flashcard> {
        return NSFetchRequest<Flashcard>(entityName: "Flashcard")
    }

    @NSManaged public var answer: String?
    @NSManaged public var id: UUID?
    @NSManaged public var orderNumber: Int16
    @NSManaged public var question: String?
    @NSManaged public var origin: FlashcardSet?

    public var wrappedAnswer: String {
        answer ?? "No Answer"
    }
    public var uuid: UUID {
        id ?? UUID()
    }
    public var wrappedQuestion: String {
        question ?? "No Question"
    }

}
