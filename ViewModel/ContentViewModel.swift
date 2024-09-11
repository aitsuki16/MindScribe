import Foundation

class ContentViewModel: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    public let dataManager: DataManager = DataManager()

    func loadEntries() {
        entries = dataManager.loadDiaryEntries()
    }

    func deleteEntry(entry: DiaryEntry) {
        dataManager.deleteDiaryEntry(entry: entry)
        // Remove
        if let index = entries.firstIndex(where: { $0 == entry }) {
            entries.remove(at: index)
        }
    }
}
