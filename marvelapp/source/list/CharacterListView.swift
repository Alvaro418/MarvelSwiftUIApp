//
//  ContentView.swift
//  Shared
//
//  Created by Alvaro Exposito on 19/11/2020.
//

import SwiftUI
import UIKit

struct CharacterListView: View {
    
    @ObservedObject var viewModel = CharacterListViewModel()
    @State var characterList: [Result] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(characterList) { character in
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterView(character: character)
                    }
                }
            }
            .navigationBarTitle("Characters")
            .onReceive(self.viewModel.characterList) {
                self.characterList = $0
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}


