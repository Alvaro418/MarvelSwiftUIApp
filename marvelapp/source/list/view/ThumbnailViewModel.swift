//
//  CharacterViewModel.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import SwiftUI
import Combine

enum ThumbnailSize: String {
    case portraitSmall = "portrait_small"
    case portraitMedium = "portrait_medium"
    case portraitXlarge = "portrait_xlarge"
    case portraitFantastic = "portrait_fantastic"
    case portraitUncanny = "portrait_uncanny"
    case portraitIncredible = "portrait_incredible"
}

/// ViewModel used to handle Thumbnail Image
class ThumbnailViewModel: ObservableObject {
    
    var request:AnyCancellable?
    var image = PassthroughSubject<Image,Never>()
    
    func loadThumbnail(imageUlr: String, extensionImage: String, size: ThumbnailSize) {
        
        guard let urlValue = URL(string: imageUlr + "/\(size.rawValue)." + extensionImage) else { return }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlValue)
            .map { $0.data }
            .compactMap { UIImage(data: $0) }
            .map { Image(uiImage: $0) }
            .receive(on: DispatchQueue.main)
        
        request = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error) : print("Error \(error)")
            case .finished: break
            }
            
        }, receiveValue: { imageValue in
            self.image.send(imageValue)
        })
    }
}
