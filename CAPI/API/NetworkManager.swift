import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>(endpoint: Endpoint) async throws -> T
}

enum NetworkError: Error, LocalizedError {
    case badURL
    case requestFailed
    case invalidResponse
    case decodingError
    case unknown

    var errorDescription: String? {
        switch self {
        case .badURL: return "The URL is invalid."
        case .requestFailed: return "The network request failed."
        case .invalidResponse: return "The server returned an invalid response."
        case .decodingError: return "Failed to decode the response."
        case .unknown: return "An unknown error occurred."
        }
    }
}

final class NetworkManager: NetworkService {
    
    private let session: URLSession
    
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(endpoint: Endpoint) async throws -> T {
        guard let url = endpoint.url() else {
            throw NetworkError.badURL
        }
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60.0)
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decodedData = try! decoder.decode(T.self, from: data)
        return decodedData
    }
}

