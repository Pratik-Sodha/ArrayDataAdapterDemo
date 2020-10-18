//
//  SubtitleTableCell.swift
//  ArrayDataAdapterDemo
//
//  Created by APPLE on 04/10/20.
//

import UIKit

class SubtitleTableCell: UITableViewCell {

    static let reuseIdentifier = "SubtitleTableCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var sortOption : SortOption! {
        didSet {
            textLabel?.text = sortOption.title
            detailTextLabel?.text = sortOption.subTitle
        }
    }
    
    var filterOptionText : String! {
        didSet {
            textLabel?.text = filterOptionText
        }
    }
    
}
