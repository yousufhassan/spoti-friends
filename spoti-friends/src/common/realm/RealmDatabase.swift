import Foundation
import RealmSwift

class RealmDatabase {
    static let shared: RealmDatabase = RealmDatabase()
    private let realm: Realm
    private let schemaVersion: UInt64 = 8  // Increment this when making schema changes
    
    init() {
        // Use this configuration when opening realms
        let config = Realm.Configuration(schemaVersion: self.schemaVersion)
        Realm.Configuration.defaultConfiguration = config
        self.realm = try! Realm()
        
        // For debugging
        // printRealmOnDeviceLocation()
    }
    
    /// Returns the Realm instance.
    public func getRealmInstance() -> Realm {
        return self.realm
    }
    
    /// Adds the `object` to the Realm.
    public func addToRealm(object: Object) -> Void {
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.add(object)
            }
        }
    }
    
    /// Prints the location where the Realm is stored on the device.
    private func printRealmOnDeviceLocation() -> Void {
        printInfo("User Realm User file location is \(self.realm.configuration.fileURL!.path)")
    }
}
