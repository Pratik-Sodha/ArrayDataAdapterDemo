//
//  ArrayDataAdapter.swift
//  ArrayDataAdapterDemo
//
//  Created by Pratik Sodha on 04/10/20.
//

import Foundation
class ArrayDataAdapter<ItemType> {
    
    let items : [ItemType]
    private(set) var operationalItems : [ItemType] = []
    private(set) var sortedItems : [ItemType] = []
    private(set) var filteredItems : [ItemType] = []
    
    init(items : [ItemType]) {
        self.items = items
        invalidate()
    }
    
    var filterBlock: (([ItemType]) -> [ItemType])?  {
        didSet {
            invalidate()
        }
    }

    var sortComparator: ((ItemType,ItemType) -> Bool)? {
        didSet {
            invalidate()
        }
    }

    //----------------------------------
    
    private func invalidate() {
        invalidateSorting()
        invalidateFiltering()
        invalidateOperationalData()
    }
    
    private func invalidateSorting()  {
        guard let _sortComparator = sortComparator else {
            sortedItems = items
            return
        }
        sortedItems = items.sorted(by: _sortComparator)
    }
    
    private func invalidateFiltering() {
        filteredItems =  filterBlock?(items) ?? items
    }
    
    private func invalidateOperationalData() {
        operationalItems = filterBlock?(sortedItems) ?? sortedItems
        
    }
}
