import Foundation
import CoreData


extension DiaryEntry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryEntry> {
        return NSFetchRequest<DiaryEntry>(entityName: "DiaryEntry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?
    @NSManaged public var handwritingData: Data?
}

extension DiaryEntry : Identifiable {

}
