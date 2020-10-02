//
//  myOrdersCellCollectionViewCell.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 10/2/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class myOrdersCell: UICollectionViewCell {
    
    @IBOutlet var cost: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var bill: UIButton!

    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var previewView: UIView!
    
    @IBOutlet var confirmedLabel: UILabel!
    @IBOutlet var confirmedView: UIView!
    
    @IBOutlet var sentLabel: UILabel!
    @IBOutlet var sentView: UIView!
    
    @IBOutlet var completedLabel: UILabel!
    @IBOutlet var completedView: UIView!
}
