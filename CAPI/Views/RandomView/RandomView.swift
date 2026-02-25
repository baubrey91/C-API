import SwiftUI

struct RandomView: View {
    @StateObject private var randomViewModel = RandomViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            if let random = randomViewModel.randomCapybara {
                AsyncImage(url: URL(string: random.url)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: random.adjustedSize.width, height: random.adjustedSize.height)
            } else {
                ProgressView()
            }
            Spacer()
            Button("RANDOM") {
                Task {
                    randomViewModel.randomCapybara = nil
                    await randomViewModel.fetchRandom()
                }
            }
        }.onDisappear {
            randomViewModel.randomCapybara = nil
        }.task {
            await randomViewModel.fetchRandom()
        }
    }
}
