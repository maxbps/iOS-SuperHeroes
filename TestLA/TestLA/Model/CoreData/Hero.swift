
import Foundation
import CoreData

class Hero: NSManagedObject {
    static var all: [Hero]{
        let request: NSFetchRequest<Hero> = Hero.fetchRequest()
        guard let heroes = try? AppDelegate.viewContext.fetch(request) else{
            return []
        }
        return heroes
    }
}
