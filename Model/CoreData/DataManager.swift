import Foundation

class DataManager {
    func save(diary: DiaryEntry) {
        CoreDataRepository.shared.save(item: diary)
    }
    
    func loadDiaryEntries () -> [DiaryEntry] {
        CoreDataRepository.shared.fetch()
    }
    
    func updateDiaryEntry(entry: DiaryEntry) {
            CoreDataRepository.shared.saveContext() 
        }
    
    func deleteDiaryEntry(entry: DiaryEntry) {
            CoreDataRepository.shared.delete(item: entry)
            CoreDataRepository.shared.saveContext()
        }
}
