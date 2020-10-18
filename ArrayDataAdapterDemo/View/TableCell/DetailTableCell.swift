//
//  DetailTableCell.swift
//  ArrayDataAdapterDemo
//
//  Created by APPLE on 04/10/20.
//

import UIKit

class DetailTableCell: UITableViewCell {

    @IBOutlet weak var imgPoster : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblDetail : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgPoster.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    static let cellReusableIdentifer = "DetailTableCell"
    
    var series : WebSeires! {
        didSet {
            imgPoster.image = series.image
            lblName.text = series.name
            lblDetail.text = "\(series.rating) | \(series.genreStringValue)"
            lblDescription.text = series.description
        }
    }
}
