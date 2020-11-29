//
//  CharacterListViewModel.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 24/11/2020.
//

import Combine
import SwiftUI

/// ViewModel to handle the character list
class CharacterListViewModel: ObservableObject {
    
    var characterList = PassthroughSubject<[Result],Never>()
    
    var request:AnyCancellable?
    
    init() {
        getCharacters()
    }
    
    /// Method used to generate a Request to get the Characters List Information and explore it
    func getCharacters() {
                        
        guard var urlCharacterList = URLComponents(string: UrlBase.list.getUrl()) else { return }
        urlCharacterList.queryItems = Authentication.generateHeaders()
        
        guard let urlCharacterListRequest  = urlCharacterList.url else { return }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlCharacterListRequest)
            .map { $0.data }
            .decode(type: CharacterListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
        request = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error) : print("Error \(error)")
            case .finished: break
            }
            
        }, receiveValue: {
            self.characterList.send($0.data?.results ?? [])
        })
    }
}
