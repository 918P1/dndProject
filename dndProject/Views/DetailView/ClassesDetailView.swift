//
//  ClassesDetailView.swift
//  dnd
//
//
import SwiftUI

struct ClassesDetailView: View {
    
    var classSelected : Result
        
    @StateObject private var detailViewModel = DetailViewModel()
    @State private var showsAlert = false
        
    var body: some View {
        NavigationView{
            List(detailViewModel.classesandDescrip, id: \.id){ item in
                    VStack(alignment: .leading){
                        detailCell(results: item)
                    }.navigationTitle("Spells")
            }.task {
                await detailViewModel.loadData(classSelected: classSelected)
                if detailViewModel.classResults.count == 0{
                    showsAlert = true
                }
        }
        .alert("\(classSelected.name) has no spells to cast", isPresented: self.$showsAlert) {}

      }

    }
        
        struct detailCell : View {
    
            var results : SpellsandDescription
    
            var body: some View{
                Text("\(results.name)")
                    .fontWeight(.bold)
                Text(results.desc.joined(separator: ""))
                    .fontWeight(.light)
            }
        }
}
