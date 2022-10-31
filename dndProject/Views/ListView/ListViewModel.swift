//
//  ListViewModel.swift
//  dndProject
//
//  Created by Chad Parr on 10/26/22.
//

import Foundation

final class ListViewModel : ObservableObject{
    
    @Published var results = [Result]()//published observes state change
    
    func loadData() async{
        guard let url = URL(string: "https://www.dnd5eapi.co/api/classes") else {
            return
        }

        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodeRespone = try? JSONDecoder().decode(Response.self, from: data){
                DispatchQueue.main.async{
                    self.results = decodeRespone.results
                }
            }
        } catch {
            print("bad data")
        }
    }
}
