import SwiftUI

struct FactsView: View {
    
    @StateObject var factsViewModel = FactsViewModel()
    
    var body: some View {
        VStack {
            switch factsViewModel.state {
            case .loading:
                ProgressView()
                    .task {
                        await factsViewModel.getFacts()
                    }
            case .error(let error):
                ErrorView(state: $factsViewModel.state, error: error,)
            case .loaded:
                List {
                    ForEach(factsViewModel.facts, id: \.self) { fact in
                        Text(fact)
                    }
                    if factsViewModel.facts.count >= 10 {
                        HStack {
                            Spacer()
                            ProgressView()
                                .onAppear {
                                    Task { await factsViewModel.getFacts() }
                                }
                            Spacer()
                            
                        }
                    }
                }
            }
        }
    }
}
