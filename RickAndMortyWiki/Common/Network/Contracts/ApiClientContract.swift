import Foundation

protocol ApiClientContract {
    func performRequest<E: ApiRouterContract>(endpoint: E) async throws -> Data
}
