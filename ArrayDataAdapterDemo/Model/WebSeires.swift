//
//  WebSeires.swift
//  ArrayDataAdapterDemo
//
//  Created by APPLE on 04/10/20.
//

import Foundation
import UIKit
struct WebSeires : Codable {
    let name            : String
    let imageName       : String
    let rating          : Double
    let genre           : [String]
    let numberOfSeasons : Int
    let description     : String
}

extension WebSeires  {
    var image : UIImage? {
        return UIImage(named: imageName)
    }

    var genreStringValue : String {
        return genre.joined(separator: ",")
    }
}
//MARK:- Sort Descriptor
extension WebSeires {
    
    static var nameSortDescriptorAscending : (WebSeires,WebSeires) -> Bool = { lhs, rhs in
        return lhs.name < rhs.name
    }
    
    static var nameSortDescriptorDecending : (WebSeires,WebSeires) -> Bool = { lhs, rhs in
        return lhs.name > rhs.name
    }
    
    static var ratingSortDescriptorAscending : (WebSeires,WebSeires) -> Bool = { lhs, rhs in
        return lhs.rating < rhs.rating
    }
    
    static var ratingSortDescriptorDecending : (WebSeires,WebSeires) -> Bool = { lhs, rhs in
        return lhs.rating > rhs.rating
    }
    
}


//MARK:- JSON file loading
extension WebSeires {
    
    static func loadUsingJSON() -> [WebSeires] {
        
        guard let resourceUrl = Bundle.main.url(forResource: "response", withExtension: "json") else {
            return []
        }
        do {
            
            let jsonData = try Data.init(contentsOf: resourceUrl)
            let tempalte = try JSONDecoder().decode([WebSeires].self, from: jsonData)
            return tempalte
        } catch {
            print("Decoding Fail ==::\(error)")
        }
        return []
    }
}
