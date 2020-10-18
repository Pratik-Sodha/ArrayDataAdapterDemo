//
//  SortOption.swift
//  ArrayDataAdapterDemo
//
//  Created by APPLE on 04/10/20.
//

import Foundation
enum SortOption : CaseIterable {
    
    case `default`
    case nameAscending
    case nameDescending
    case ratingAscending
    case ratingDescending
    
    var title : String {
        switch self {
        case .default:
            return "None"
        case .nameAscending, .nameDescending:
            return "Name"
        case .ratingAscending, .ratingDescending:
            return "Rating"
        }
    }
    
    var subTitle : String {
        switch self {
        case .default:
            return "Default element ordering"
        case .nameAscending:
            return "A->Z"
        case .nameDescending:
            return "Z->A"
        case .ratingAscending:
            return "Low->High"
        case .ratingDescending:
            return "High->Low"
        }
    }
    
    var sortDescriptor : ((WebSeires,WebSeires) -> Bool)? {
        switch self {
        case .default:
            return nil
        case .nameAscending:
            return WebSeires.nameSortDescriptorAscending
        case .nameDescending:
            return WebSeires.nameSortDescriptorDecending
        case .ratingAscending:
            return WebSeires.ratingSortDescriptorAscending
        case .ratingDescending:
            return WebSeires.ratingSortDescriptorDecending
        }
    }
}
