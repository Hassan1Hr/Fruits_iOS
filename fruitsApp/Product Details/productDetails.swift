//
//  productDetails.swift
//  perfume
//
//  Created by Bassam Ramadan on 9/9/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import DropDown
class productDetails: common{
    
    //MARK:- Outlets
    @IBOutlet var name:UILabel!
    @IBOutlet var price:UILabel!
    @IBOutlet var image: UIImageView!
    @IBOutlet var discription: UILabel!
    @IBOutlet var count: UILabel!
    @IBOutlet var dropButton: UIButton!
    
    //MARK:- Variables
    var dropDown = DropDown()
    var totalCount: Double? = 0.0
    var startFrom: Double? = 0.0
    var data: products? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupDropDown(dropButton)
    }
    
    //MARK:- functions
    fileprivate func setupStartPrice(index: Int) {
        price.text = data?.weightUnits?[index].weightPrice ??  "0"
        startFrom = Double(data?.weightUnits?[index].startFrom ?? "0")
        count.text = "\(startFrom ?? 0.0)"
        totalCount = startFrom
    }
    
    fileprivate func setupData(){
        if data != nil {
            name.text = data?.name ?? ""
            image.sd_setImage(with: URL(string: data?.imagePath ?? ""))
            discription.text = data?.datumDescription ?? ""
            if data?.weightUnits?.count ?? 0 > 0{
                setupStartPrice(index: 0)
            }
        }
    }
    
    fileprivate func setupDropDown(_ sender: UIButton) {
        dropDown.anchorView = (sender as AnchorView)
        dropDown.dataSource = parsingData(self.data?.weightUnits ?? [])
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        if dropDown.dataSource.count > 0{
            dropDown.selectRow(at: 0)
            dropButton.setTitle(dropDown.selectedItem, for: .normal)
        }
    }
    func parsingData(_ data : [WeightUnit])->[String]{
        var ResData = [String]()
        for x in data {
            ResData.append("\(x.weightUnit ?? "")")
        }
        return ResData
    }
    
    //MARK:- Actions
    @IBAction func dropDown(_ sender: UIButton) {
        dropDown.selectionAction = {
            [unowned self](index : Int , item : String) in
                sender.setTitle(item, for: .normal)
                self.setupStartPrice(index: index)
           }
        dropDown.show()
    }
    
    @IBAction func close(){
       super.dismiss(animated: true)
    }
    @IBAction func plus(){
        if let p = startFrom{
            totalCount = (totalCount ?? 0.0) + p
            count.text = "\(totalCount ?? 0.0)"
        }
    }
    @IBAction func minus(){
        if totalCount != startFrom{
            if let p = startFrom{
                totalCount = (totalCount ?? 0.0) - p
                count.text = "\(totalCount ?? 0.0)"
            }
        }
    }
    @IBAction func addToCart(){
        
        if CashedData.getUserApiKey() == "" || CashedData.getUserApiKey() == nil{
            openRegisteringPage(pagTitle: "login")
        }else{
            
        }
    }
}
