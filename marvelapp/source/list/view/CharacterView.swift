//
//  CharacterView.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import SwiftUI

struct CharacterView: View {
    
    let character: Result
    let thumbnailViewModel = ThumbnailViewModel()
    @State var characterImage = Image(systemName: "person.fill")
    
    var body: some View {
        
        HStack {
            characterImage
                .resizable()
                .modifier(ImagenStyle())
                .frame(width: 35, height: 50)
            
            Text(character.name ?? "<Nombre>")
        }.onReceive(self.thumbnailViewModel.image) { image in
            self.characterImage = image
        }.onAppear {
            if let path = character.thumbnail?.path,
               let extensionImage = character.thumbnail?.thumbnailExtension?.rawValue {
                self.thumbnailViewModel.loadThumbnail(imageUlr: path, extensionImage: extensionImage, size: .portraitSmall)
                
            }
        }
    }
}
