import Foundation

struct ApiException: LocalizedError {
    // MARK: - properties
    let statusCode: ApiStatusCode
    
    // MARK: - init method
    init(statusCode: ApiStatusCode) {
        self.statusCode = statusCode
    }
    
    // MARK: - LocalizedError
    var errorDescription: String? {
        return statusCode.description
    }
}
