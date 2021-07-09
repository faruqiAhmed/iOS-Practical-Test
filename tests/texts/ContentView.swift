//
//  ContentView.swift
//  texts
//
//  Created by Md Omar Faruq on 7/7/21.
//

import SwiftUI

struct ContentView: View {
     
    @ObservedObject var viewModel: QuranListViewModel
    var body: some View {
        NavigationView
        {
            VStack{
                SearchBar(searchTerm: $viewModel.searchTerm )
                if viewModel.resultls.isEmpty{
                   // EmptyStateView()
                } else{
                    List(viewModel.resultls) { quran in
                         QuranView(quran: quran)
                    }
                }
                   
                
            }
            .navigationTitle("quran")
        }
        
        
        
        
        
    }
}

struct QuranView: View {
  @ObservedObject var quran: QuranViewModel
  
  var body: some View {
    
    
    HStack {
        
      VStack {
        Text(quran.text)
            .font(.footnote)
            .foregroundColor(.gray)
        ZStack{
            Spacer()
        Text("translations")
            
        }
      }
    }
    .padding()
  }
}

struct QuratView: View {
    var body: some View{
    VStack(alignment: .leading){
        Text("show")
            .font(.footnote)
            .foregroundColor(.gray)
    }
}
}
//struct EmptyStateView: View {
//  var body: some View {
//    VStack {
//      Spacer()
//
//     //Image(systemName: "music.note")
//        .font(.system(size: 85))
//        .padding(.bottom)
//      Text("Start searching quran Verses ")
//        .font(.title)
//      Spacer()
//    }
//    .padding()
//    .foregroundColor(Color(.systemIndigo))
//  }
//}

struct SearchBar: UIViewRepresentable  {
    typealias UIView = UISearchBar
    @Binding var searchTerm: String
    func makeUIView(context: Context) -> UISearchBar {
       let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = " type quran Verses "
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        
    }
    
    func makeCoordinator() -> SearchBarCoordinator {
        return SearchBarCoordinator(searchTeam: $searchTerm)
    }
    
    class SearchBarCoordinator: NSObject, UISearchBarDelegate{
        
        @Binding var searchTerm: String
        
        init(searchTeam: Binding<String>) {
            self._searchTerm = searchTeam
        }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchTerm = searchBar.text ?? ""
            UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
          
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: QuranListViewModel())
    }
}
