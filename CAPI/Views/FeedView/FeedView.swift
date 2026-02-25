import SwiftUI
import Combine

struct FeedView: View {
    @StateObject private var feedViewModel = FeedViewModel()

    var body: some View {
        List {
            ForEach(feedViewModel.capybaras) { capybara in
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: capybara.url)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: capybara.adjustedSize.width, height: capybara.adjustedSize.height)
                    Spacer()
                }
            }
            // TODO: Clean Up
            if feedViewModel.capybaras.count >= 10 {
                HStack {
                    Spacer()
                    ProgressView()
                        .onAppear {
                            Task { await feedViewModel.getCapybaras() }
                        }
                    Spacer()
                    
                }
            }
        }
        .task {
            await feedViewModel.getCapybaras()
        }
    }
}
