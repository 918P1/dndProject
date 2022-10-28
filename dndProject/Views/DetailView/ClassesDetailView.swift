//
//  ClassesDetailView.swift
//  dnd
//
//
import SwiftUI

struct ClassesDetailView: View {
    
    var classSelected : Result
    
    @State private var showAlert = true
    
    @State private var alertItem: AlertItem?

    @StateObject private var detailViewModel = DetailViewModel()
        
    var body: some View {
        NavigationView{
            List(detailViewModel.classesandDescrip, id: \.id){ item in
                    VStack(alignment: .leading){
                        detailCell(results: item)
                    }.navigationTitle("Spells")
        }.task {
            await detailViewModel.loadData(classSelected: classSelected)
            if detailViewModel.classResults.count == 0{
//                print("no spells")
                showAlert = true
                Button("\(classSelected.name) has no spells") {
                           showAlert = true
                       }
                       .alert("\(classSelected.name) has no spells to cast", isPresented: $showAlert) {
                           Button("OK", role: .cancel) { }
                       }
//                
             
//                   
                
            }
//                .alert("\(classSelected.name) has no spells to cast", isPresented: $showAlert) {
//                                         Button("OK", role: .cancel) { }
//                                      }
        }
            
        
            
//        .alert(item: $alertItem) { alertItem in
//            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
//        }
    }
       
        
    }
    
    struct LoadingAlert: ViewModifier {
        @Binding var isPresented: Bool

        func body(content: Content) -> some View {
            content
                .alert(isPresented: $isPresented) {
                    Alert(title: Text(NSLocalizedString("Loading", comment: "")),
                          dismissButton: .none)
                }
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
