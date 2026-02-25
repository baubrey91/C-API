import SwiftUI

protocol InfiniteScrollable {
    var isLoading: Bool { get set }
}

final class FeedViewModel: ObservableObject, InfiniteScrollable {
    
    @Published var capybaras = [Capybara]()
    private let networkManager: NetworkManager
    private var index = 1
    var isLoading = false
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getCapybaras() async {
        guard !isLoading else { return }
        isLoading = true
        let capybaras: CapybaraFeedResponse = try! await networkManager.fetchData(endpoint: .feed(index: index))
        index += 10

        Task { @MainActor in
            self.capybaras += capybaras.data
            isLoading = false
        }
    }
}
