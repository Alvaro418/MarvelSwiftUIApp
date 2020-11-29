//
//  CharacterDetailView.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import SwiftUI

struct CharacterDetailView: View {
    
    let character: Result
    let thumbnailViewModel = ThumbnailViewModel()
    let characterDetailViewModel = CharacterDetailViewModel()
    
    @State var comicList: [ComicsItem] =  []
    @State var seriesList: [ComicsItem] =  []
    @State var storiesList: [ComicsItem] =  []
    @State var eventsList: [ComicsItem] =  []
    
    @State var characterImage = Image(systemName: "person.fill")
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text(character.resultDescription ?? "Sin Descripción")
                .font(.subheadline)
                .lineLimit(nil)
            
            characterImage
                .resizable()
                .modifier(ImagenStyle())
                .frame(width: 100, height: 150)
                .padding()
            
            List {
                ComicItemRowView(title: "Comic", itemList: $comicList)
                ComicItemRowView(title: "Series", itemList: $seriesList)
                ComicItemRowView(title: "Stories", itemList: $comicList)
                ComicItemRowView(title: "Events", itemList: $comicList)
            }
            
            Spacer(minLength: 30.0)
        }
        .padding()
        .navigationTitle(self.character.name ?? "Character Detail")
        .onAppear {
            
            self.characterDetailViewModel.getCharacterDetail(characterID: character.id)
            
        }.onReceive(self.thumbnailViewModel.image) { image in
            self.characterImage = image
        }.onReceive(self.characterDetailViewModel.events) { events in
            self.eventsList = events
        }.onReceive(self.characterDetailViewModel.stories) { stories in
            self.storiesList = stories
        }.onReceive(self.characterDetailViewModel.series) { series in
            self.seriesList = series
        }.onReceive(self.characterDetailViewModel.comic) { comic in
            self.comicList = comic
        }.onReceive(self.characterDetailViewModel.thumbnailURL) { (path,extensionUrl) in
            self.thumbnailViewModel.loadThumbnail(imageUlr: path, extensionImage: extensionUrl, size: .portraitXlarge)
        }
    }
}

//struct CharacterDetailView_Previews: PreviewProvider {
//    static var previews: some View {
////        CharacterDetailView(character: character)
//    }
//}
