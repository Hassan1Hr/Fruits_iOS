//
//  myOrdersCellCollectionViewCell.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 10/2/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class myOrdersCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet var cost: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var number: UILabel!
    @IBOutlet var bill: UIButton!
    
    @IBOutlet var confirmeLab: UILabel!
    @IBOutlet var confirmeView: UIView!
    
    @IBOutlet var sentLab: UILabel!
    @IBOutlet var sentView: UIView!
     
    @IBOutlet var completeLab: UILabel!
    @IBOutlet var completeView: UIView!
   
    var status: String = "preview"{
        didSet{
            setDefault()
            switch self.status {
            case "confirmed":
                DispatchQueue.main.async{
                self.setColorToLabel("green",self.confirmeLab,self.confirmeView)
                }
            case "completed":
                DispatchQueue.main.async{
                self.setColorToLabel("green",self.confirmeLab,self.confirmeView)
                self.setColorToLabel("completeSend",self.sentLab,self.sentView)
                self.setColorToLabel("Walnut",self.completeLab,self.completeView)
                }
            case "rejected":
                DispatchQueue.main.async{
                self.confirmeLab.text = "مرفوض"
                self.setColorToLabel("red",self.confirmeLab,self.confirmeView)
                }
            default:
                DispatchQueue.main.async{
                self.setColorToLabel("green",self.confirmeLab,self.confirmeView)
                self.setColorToLabel("completeSend",self.sentLab,self.sentView)
                }
            }
        }
    }
    fileprivate func setDefault(){
        DispatchQueue.main.async{
            self.setColorToLabel("lightGray",self.sentLab,self.sentView)
            self.setColorToLabel("lightGray",self.completeLab,self.completeView)
            self.setColorToLabel("lightGray",self.confirmeLab,self.confirmeView)
            self.confirmeLab.text = "تم التأكيد"
        }
    }

    fileprivate func setColorToLabel(_ colorName: String,_ label: UILabel,_ view: UIView){
        let color = UIColor(named: colorName) ?? UIColor.red
        label.textColor = color
        view.backgroundColor = color
    }
}
