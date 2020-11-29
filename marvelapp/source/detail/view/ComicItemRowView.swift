//
//  ComicItemRowView.swift
//  marvelapp
//
//  Created by Alvaro Exposito on 25/11/2020.
//

import SwiftUI

struct ComicItemRowView: View {
    
    @State var title: String
    @Binding var itemList: [ComicsItem]
    
    var body: some View {
        if (itemList.count > 0) {
            Section(header: Text(title)) {
                ForEach(0 ..< itemList.count, id: \.self) { i in
                    Text(itemList[i].name ?? "")
                }
            }
        } else {
            Text("No \(title) to show ...  :(")
        }
    }
}
