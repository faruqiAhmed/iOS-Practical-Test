//
//  DataModel.swift
//  texts
//
//  Created by Md Omar Faruq on 7/7/21.
//

import Foundation
class DataModel {
  
  private var dataTask: URLSessionDataTask?
  
  func loadQuran(searchTerm: String = "quran", completion: @escaping(([Verse]) -> Void)) {
    dataTask?.cancel()
    var searchTerm=searchTerm
    if searchTerm.count==0 {
       searchTerm = "quran"
    }
    
    guard let url = buildUrl(forTerm: searchTerm) else {
      completion([])
      return
    }
    
    dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
      guard let data = data else {
        completion([])
        return
      }
      
      if let verseResponse = try? JSONDecoder().decode(QuranResponse.self, from: data) {
        completion(verseResponse.results)
      }
//      else if  let Translation = try JSONDecoder().decode(QuranResponse.self, from: Data) {
//        completion(translation.translations)
//      }
    }
    dataTask?.resume()
  }
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        guard !searchTerm.isEmpty else {
            return nil}
            let  queryItems = [
                URLQueryItem(name: "q", value: searchTerm),
                URLQueryItem(name: "size", value: "20" ),
                URLQueryItem(name: "page", value: "0" ),
            ]
            
            var components = URLComponents(string:"https://api.quran.com/api/v3/search")
                components?.queryItems = queryItems
                
                return components?.url
        }
    
    
}


struct QuranResponse: Decodable  {
    let query: String
    let  total_results: Int
    let  current_page: Int
    let total_pages: Int
    let results: [Verse]
  
}




struct Verse: Decodable {
    let verse_id: Int
    let text: String
    let translations:[Translation]
    
}
struct Translation: Decodable {
    let name: String
    let id: Int
    let text:String
    
}

