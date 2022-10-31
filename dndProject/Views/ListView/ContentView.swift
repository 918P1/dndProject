//
//  ContentView.swift
//  dndProject
//
//  Created by Chad Parr on 10/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ListViewModel()//link to view model
    @State private var showsAlert = false

    
    var body: some View {
        Text("Dungeons and Dragons")
        NavigationView{
            List(viewModel.results, id: \.name){ item in
                NavigationLink(destination: ClassesDetailView(classSelected: item)) {//link to detail view
                    dndCell(results: item)//custom cell
                }.navigationBarTitle(Text("DnD Class Spells"))
            }.task {
                    await viewModel.loadData()//retrieve data and wait
                if viewModel.results.count == 0{
                    showsAlert = true
                }
            }
            .alert("Check your network connection", isPresented: self.$showsAlert) {}

        }
    }
    
    struct dndCell : View {
        
        var results : Result
        
        var body: some View{
            VStack(alignment: .leading){
                Text("\(results.name)")//customize text
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.7)
                    .lineLimit(2)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()//preview of the ui
        }
    }
}
