//
//  ContentView.swift
//  Shared
//
//  Created by Alvaro Exposito on 19/11/2020.
//

import SwiftUI
import Combine
import UIKit

struct CharacterListView: View {
    
    @EnvironmentObject var sources:DataDataSource
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sources.empleados) { empleado in
                    FilaViewEmpleado(empleado: empleado)
                }
            }
            .navigationBarTitle("Productos")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}


struct FilaViewEmpleado:View {
    
    let empleado:Producto
    
    @State var imagen = Image(systemName: "person.crop.circle.fill")
    @ObservedObject var viewModel = ProductViewModel()
    
    var body:some View {
        HStack {
            self.imagen
                .resizable()
                .aspectRatio(contentMode: .fit)
                .modifier(ImagenStyle())
            VStack(alignment: .leading) {
                Text("\(empleado.productName)")
                    .font(.headline)
                Text(empleado.description)
                    .font(.subheadline)
            }
        }
        .onAppear {
            self.viewModel.loadImage(url: self.empleado.avatar)
        }
        .onReceive(self.viewModel.subject) { image in
            self.imagen = image
        }
        .onDisappear() {
            self.viewModel.request?.cancel()
        }
    }
}

class ProductViewModel:ObservableObject {
    
    var request:AnyCancellable?
    
    var subject = PassthroughSubject<Image,Never>()
    
    func loadImage(url:URL) {
        
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
        //            .map { $0.data }
        //            .compactMap { UIImage((data: $0)) }
        //            .map { Image(uiImage: $0) }
        //            .receive(on: DispatchQueue.main)
        //
        //        request = publisher.sink(receiveCompletion: { completion in
        //            switch completion {
        //            case .failure(let error) : print("Error \(error)")
        //            case .finished: print("Ok")
        //            }
        //
        //        }, receiveValue: {
        //            self.subject.send($0)
        //        })
    }
}

struct ImagenStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 80, height: 50)
            .background(Color.gray)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
            .shadow(radius: 10.0)
    }
}

struct Producto: Codable, Identifiable, Hashable {
    
    let id: Int
    let productName, description: String
    let avatar: URL
    
    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case description, avatar
    }
}

class DataDataSource:ObservableObject {
    
    var subject = PassthroughSubject<[Result],Never>()
    
    var request:AnyCancellable?
    
    func getCharacters() {
        
        let url = "https://gateway.marvel.com:443/v1/public/characters?apikey=00e3184146e5d1051d872491600b4e83";
        
        guard let urlValue = URL(string: url) else { return }
        
        let publisher = URLSession.shared.dataTaskPublisher(for: urlValue)
            .map { $0.data }
            .decode(type: [Result].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
        request = publisher.sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error) : print("Error \(error)")
            case .finished: print("Ok")
            }
            
        }, receiveValue: {
            self.subject.send($0)
        })
    }
}

typealias Productos = [Producto]
