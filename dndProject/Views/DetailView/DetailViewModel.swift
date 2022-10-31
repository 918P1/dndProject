//
//  DetailViewModel.swift
//  dndProject
//
//  Created by Chad Parr on 10/26/22.
//
//
import Foundation

@MainActor final class DetailViewModel : ObservableObject {//main actor allowsfor automatic dispatch on UI thread

    @Published var classesandDescrip = [SpellsandDescription]()//published observes state change

    @Published var classResults = [Result]()

    
    func loadData(classSelected : Result) async {
       guard let url = URL(string: "https://www.dnd5eapi.co/api/classes/\(classSelected.index)/spells") else {
           print("Bad url")
           return
       }

        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodeRespone = try? JSONDecoder().decode(Response.self, from: data){
                    self.classResults = decodeRespone.results
                var i = 0
                for result in classResults{//add all spells to an array
                    i = i + 1
                    await classesandDescrip.append(SpellsandDescription(id: i, name: result.name, desc: loadSpells(result)))
                }
            }
                
       } catch {
           print("bad data")
       }
   }
   
   func loadSpells(_ result: Result) async -> Array<String>{
                       guard let url = URL(string: "https://www.dnd5eapi.co\(result.url)") else {
                           print("Bad url")
                           return [""]
                       }
                       do{
                           let (data, _) = try await URLSession.shared.data(from: url)
                           if let decodeRespone = try? JSONDecoder().decode(Spells.self, from: data){//use spells struct for data
                               return decodeRespone.desc
                           }

                       } catch {
                           print("bad data")
                       }
       return [""]
   }
    
}
