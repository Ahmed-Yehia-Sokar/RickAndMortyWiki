import Foundation

extension Dictionary {
    func getString(_ key: Key, defaultValue: String = "") -> String {
        if let value = self[key] as? String {
            return value
        }
        
        return defaultValue
    }
    
    func getArray<T>(_ key: Key, defaultValue: [T] = []) -> [T] {
        if let value = self[key] as? [T] {
            return value
        }

        return defaultValue
    }
}
