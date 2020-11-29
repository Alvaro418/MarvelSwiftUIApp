//
//  CharacterDetailViewController.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import Combine
import SwiftUI

class CharacterDetailViewModel: ObservableObject {
    
    func getCharacterDetail(characterID: Int) {
                
        let url = "https://gateway.marvel.com/v1/public/characters/\(characterID)\(AuthenticationComponents.generateHeaders())";
        
        guard let urlValue = URL(string: url) else { return }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlValue)
            .map { $0.data }
            .decode(type: CharacterListModel.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
//        request = publisher.sink(receiveCompletion: { completion in
//            switch completion {
//            case .failure(let error) : print("Error \(error)")
//            case .finished: print("Ok")
//            }
//
//        }, receiveValue: {
//            self.characterList.send($0.data?.results ?? [])
//        })
    }

}
