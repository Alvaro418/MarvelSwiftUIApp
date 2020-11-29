//
//  CharacterDetailViewController.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import Combine
import SwiftUI

class CharacterDetailViewModel: ObservableObject {
    
    var comic = PassthroughSubject<[ComicsItem],Never>()
    var series = PassthroughSubject<[ComicsItem],Never>()
    var stories = PassthroughSubject<[ComicsItem],Never>()
    var events = PassthroughSubject<[ComicsItem],Never>()
    var thumbnailURL = PassthroughSubject<(String,String),Never>()
    
    var request:AnyCancellable?
    
    func getCharacterDetail(characterID: Int?) {
        
        guard let characterID = characterID else { return }
        
        let url = "https://gateway.marvel.com/v1/public/characters/\(characterID)\(Authentication.generateHeaders())";
        
        guard let urlValue = URL(string: url) else { return }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlValue)
            .map { $0.data }
            .decode(type: CharacterDetailModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
        request = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error) : print("Error \(error)")
            case .finished: break
            }
            
        }, receiveValue: {
            
            if let result = $0.data?.results?[0] {
                if let comics = result.comics?.items { self.comic.send(comics) }
                if let series = result.series?.items { self.series.send(series) }
                if let events = result.events?.items { self.events.send(events) }
                if let stories = result.stories?.items { self.comic.send(stories) }
                
                if let path = result.thumbnail?.path, let urlExtension = result.thumbnail?.thumbnailExtension {
                    self.thumbnailURL.send((path, urlExtension.rawValue))
                }
            }
        })
    }
}
