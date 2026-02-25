import Foundation
import UIKit

struct Capybara: Decodable {
    var url: String
    var index: Int
    var width: CGFloat
    var height: CGFloat
    var alt: String
}

extension Capybara: Identifiable {
    var id: Int {
        index
    }
    
    var adjustedSize: CGSize {
        let width = UIScreen.main.bounds.size.width
        if width < self.width {
            let scale: CGFloat = width / self.width
            return CGSize(width: self.width * scale, height: self.height * scale)
        }
        return CGSize(width: self.width, height: self.height)
    }
}

struct RandomCapybaraResponse: Decodable {
    var success: Bool
    var data: Capybara
}
    

struct CapybaraFeedResponse: Decodable {
    var success: Bool
    var data: [Capybara]
}

struct FactsResponse: Decodable {
    let success: Bool
    let data: [String]
}
