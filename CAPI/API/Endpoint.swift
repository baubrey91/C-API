import Foundation

enum Endpoint {
    case feed(index: Int)
    case random
    case facts(index: Int)
    
    private var host: String {
        return "api.capy.lol"
    }

    private var path: String {
        switch self {
        case .feed: return "/v1/capybaras"
        case .random: return "/v1/capybara"
        case .facts: return "/v1/facts"
        }
    }
    
    private var queryItems: [URLQueryItem]? {
        switch self {
        case .random: return [URLQueryItem(name: "json", value: "true")]
        case .feed(let index): return [URLQueryItem(name: "from", value: String(index)),
                                      URLQueryItem(name: "take", value: "10")]
        case .facts(let index): return [URLQueryItem(name: "from", value: String(index)),
                                      URLQueryItem(name: "take", value: "25")]
        }
    }
    
    func url() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { return nil }
        return url
    }
}
