import SwiftUI

enum ViewState {
    case loading
    case loaded
    case error(Error)
}

final class FactsViewModel: ObservableObject, InfiniteScrollable {
    
    @Published var facts: [String] = []
    @Published var state: ViewState = .loading
    private let netWorkManager: NetworkManager
    private var from = 0
    var isLoading: Bool = false
    
    init (netWorkManager: NetworkManager = NetworkManager()) {
        self.netWorkManager = netWorkManager
    }
    
    func getFacts() async {
        guard !isLoading else { return }
        isLoading = true
        do {
            let facts: FactsResponse = try await netWorkManager.fetchData(endpoint: .facts(index: from))
            from += 25
            Task { @MainActor in
                isLoading = false
                self.facts += facts.data
                self.state = .loaded
            }
        } catch let error {
            self.state = .error(error)
        }
    }
}

struct ErrorView: View {
    @Binding var state: ViewState

    let error: Error
    
    var body: some View {
        Text(error.localizedDescription)
        Button(action: {
            self.state = .loading
        }) {
            Text("Try Again")
        }
    }
}
