//
//  productCell.swift
//  perfume
//
//  Created by Bassam Ramadan on 9/8/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class productCell: UICollectionViewCell{
    @IBOutlet var productName: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var productCart: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

