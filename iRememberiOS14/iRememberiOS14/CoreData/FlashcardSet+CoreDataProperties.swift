//
//  FlashcardSet+CoreDataProperties.swift
//  iRememberiOS14
//
//  Created by Mikolaj Witkowski on 25/06/2020.
//
//

import Foundation
import CoreData


extension FlashcardSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlashcardSet> {
        return NSFetchRequest<FlashcardSet>(entityName: "FlashcardSet")
    }

    @NSManaged public var name: String?
    @NSManaged public var shortname: String?
    @NSManaged public var flashcard: NSSet?
    
    public var wrappedName: String {
        name ?? "No Name"
    }
    
    public var wrappedShortname: String {
        shortname ?? "No Shortname"
    }
    
    public var flashcardArray: [Flashcard] {
        let set = flashcard as? Set<Flashcard> ?? []
        
        return set.sorted {
            $0.wrappedQuestion < $1.wrappedQuestion
        }
    }
    

}

// MARK: Generated accessors for flashcard
extension FlashcardSet {

    @objc(addFlashcardObject:)
    @NSManaged public func addToFlashcard(_ value: Flashcard)

    @objc(removeFlashcardObject:)
    @NSManaged public func removeFromFlashcard(_ value: Flashcard)

    @objc(addFlashcard:)
    @NSManaged public func addToFlashcard(_ values: NSSet)

    @objc(removeFlashcard:)
    @NSManaged public func removeFromFlashcard(_ values: NSSet)

}
