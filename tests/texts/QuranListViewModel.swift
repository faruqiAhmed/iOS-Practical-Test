//
//  QuranListViewModel.swift
//  texts
//
//  Created by Md Omar Faruq on 7/8/21.
//




import Combine
import Foundation
import SwiftUI

class QuranListViewModel: ObservableObject {
  @Published var searchTerm: String = ""
  @Published public private(set) var resultls: [QuranViewModel] = []
  
  private let dataModel: DataModel = DataModel()
  
  private var disposables = Set<AnyCancellable>()
  
  init() {
    $searchTerm
      .sink(receiveValue: loadQuran(searchTerm:))
      .store(in: &disposables)
  }
  
  private func loadQuran(searchTerm: String) {
    resultls.removeAll()
    
    
    dataModel.loadQuran(searchTerm: searchTerm) { resultls in
      resultls.forEach { self.appendQuran(quran: $0) }
    }
  }
  
  private func appendQuran(quran: Verse) {
    let QuranViewModel = QuranViewModel(quran: quran)
    DispatchQueue.main.async {
      self.resultls.append(QuranViewModel)
    }
  
  }
}


class QuranViewModel: Identifiable, ObservableObject {
  let verse_id: Int
  let text: String
   
    let translations: [Translation]
    //let results:[Verse]
  
  
  init( quran: Verse) {
    self.verse_id = quran.verse_id
    self.text = quran.text
   
   self.translations = quran.translations
    
  }
}
