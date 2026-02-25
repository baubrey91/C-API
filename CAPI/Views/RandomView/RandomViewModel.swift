import SwiftUI

final class RandomViewModel: ObservableObject {
    
    @Published var randomCapybara: Capybara? = nil
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchRandom() async {
        let response: RandomCapybaraResponse = try! await networkManager.fetchData(endpoint: .random)
        Task { @MainActor in
            self.randomCapybara = response.data
        }
    }
}
