//
//  CharacterListViewModel.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 24/11/2020.
//

import Combine
import SwiftUI

class CharacterListViewModel: ObservableObject {
    
    var characterList = PassthroughSubject<[Result],Never>()
    
    var request:AnyCancellable?
    
    init() {
        getCharacters()
    }
    
    func getCharacters() {
        
        let url = "https://gateway.marvel.com/v1/public/characters\(Authentication.generateHeaders())";
        
        guard let urlValue = URL(string: url) else { return }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlValue)
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
