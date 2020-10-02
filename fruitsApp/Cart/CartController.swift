//
//  CartController.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 9/13/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit


class cartController: common {
    
    @IBOutlet var cartItemCollection: UICollectionView!
    @IBOutlet var totalCostLabel: UILabel!
    @IBOutlet var shipping: UILabel!
    
    var data: cartData?
    var totalCosts:Double = 0.0
    var Editing = false
    var isBack = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "العربة"
        setupBackButtonWithDismiss()
        getConfig{
            data in
            self.shipping.text = (data?.shippingValue ?? "0").replacingOccurrences(of: ".00", with: "")
        }
        getCartItems{
            data in
            self.data = data
            self.totalCostLabel.text = data?.totalCost ?? "0"
            self.cartItemCollection.reloadData()
        }
        
    }
    override func setupBackButtonWithDismiss() {
        self.navigationItem.hidesBackButton = true
        let backBtn: UIButton = common.drowbackButton()
        let backButton = UIBarButtonItem(customView: backBtn)
        self.navigationItem.setRightBarButton(backButton, animated: true)
        backBtn.addTarget(self, action: #selector(self.Dismiss), for: UIControl.Event.touchUpInside)
    }
    @objc override func Dismiss() {
        if isEditing == false{
            self.navigationController?.dismiss(animated: true)
        }
        self.isBack = true
        self.saveCartItemsAfterEditing()
    }
    fileprivate func updateTotalCost(){
        totalCostLabel.text = "\(totalCosts + (Double(shipping.text ?? "0.0") ?? 0.0))"
        totalCosts = 0.0
    }
    @IBAction func deleteItem(sender: UIButton){
        deleteCartItem(index: sender.tag)
    }
    @IBAction func plus(sender: UIButton){
        if let p = Double(data?.items?[sender.tag].price ?? "0"){
            data?.items?[sender.tag].totalCost =
            "\((Double(data?.items?[sender.tag].totalCost ?? "0") ?? 0.0) + p )"
            let quantity = (Double(data?.items?[sender.tag].quantity ?? "0") ?? 0)
            data?.items?[sender.tag].quantity = "\((quantity ) + 1)"
            self.Editing = true
            self.cartItemCollection.reloadData()
        }
    }
    @IBAction func minus(sender: UIButton){
        if Double(data?.items?[sender.tag].price ?? "0") == Double(data?.items?[sender.tag].totalCost ?? "0"){
            return
        }
        if let p = Double(data?.items?[sender.tag].price ?? "0"){
            data?.items?[sender.tag].totalCost =
            "\((Double(data?.items?[sender.tag].totalCost ?? "0") ?? 0.0) - p )"
            let quantity = (Double(data?.items?[sender.tag].quantity ?? "0") ?? 0)
            data?.items?[sender.tag].quantity = "\((quantity ) - (1))"
            self.Editing = true
            self.cartItemCollection.reloadData()
        }
    }
    func getStartfrom(_ index: Int)-> Double{
        return Double(data?.items?[index].product?.weightUnits?.first(where: {$0.weightUnit == data?.items?[index].weightUnit})?.startFrom ?? "0") ?? 0.0
    }
}
extension cartController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cart", for: indexPath) as! cartItemCell
        
        let item = data?.items?[indexPath.row]
        cell.image.sd_setImage(with: URL(string: data?.items?[indexPath.row].product?.imagePath ?? ""))
        cell.name.text = data?.items?[indexPath.row].product?.name ?? ""
        cell.unit.text = item?.weightUnit ?? ""
        cell.quantity.text = "\( (Double(item?.quantity ?? "0") ?? 0.0) * getStartfrom(indexPath.row))"
        cell.price.text = item?.totalCost ?? "0"
        self.totalCosts += Double(item?.totalCost ?? "0") ?? 0.0
        cell.remove.tag = indexPath.row
        cell.plus.tag = indexPath.row
        cell.minus.tag = indexPath.row
        
        if indexPath.row+1 == data?.items?.count {
            updateTotalCost()
        }
        return cell
    }
    
    
}
extension cartController{
    func deleteCartItem(index:Int){
        self.loading()
        let url = AppDelegate.LocalUrl + "delete-cart-item"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
            "Authorization" : "Bearer " + (CashedData.getUserApiKey() ?? "")
        ]
        let info = [
            "cart_id": data?.cartID ?? 0,
            "cart_item_id": data?.items?[index].id ?? 0
        ]
        AlamofireRequests.PostMethod(methodType: "POST", url: url, info: info, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        self.present(common.makeAlert(message: "تم الحذف بنجاح"), animated: true, completion: nil)
                        self.data?.items?.remove(at: index)
                        self.cartItemCollection.reloadData()
                        self.stopAnimating()
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            }catch {
                self.present(common.makeAlert(), animated: true, completion: nil)
                self.stopAnimating()
            }
        }
    }
    @IBAction func saveCartItemsAfterEditing(){
        if Editing == false{
            return
        }
    
        self.loading()
        let url = AppDelegate.LocalUrl + "edit-cart-item"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
            "Authorization" : "Bearer " + (CashedData.getUserApiKey() ?? "")
        ]
        var items = [ItemAfterEditing]()
        for item in data?.items ?? []{
            let weightunitId = item.product?.weightUnits?.first(where: {$0.weightUnit == item.weightUnit})?.id
            items.append(.init(product_id: "\(item.product?.id ?? 0)", product_weight_unit_id: "\(weightunitId ?? 0)", quantity: item.quantity ?? "0"))
        }
        let cartItemsAfterEditing = uploadCart(cart_id: data?.cartID ?? 0, items: items)
        let data = try! JSONEncoder.init().encode(cartItemsAfterEditing)
        let dictionaryy = try! JSONSerialization.jsonObject(with: data) as! [String: Any]
        AlamofireRequests.PostMethod(methodType: "PUT", url: url, info: dictionaryy, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        if self.isBack{
                            self.isBack = false
                            self.navigationController?.dismiss(animated: true)
                        }
                        self.stopAnimating()
                    }else{
                        let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                        self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                        self.stopAnimating()
                    }
                    
                }else{
                    let dataRecived = try decoder.decode(ErrorHandle.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
                }
            }catch {
                self.present(common.makeAlert(), animated: true, completion: nil)
                self.stopAnimating()
            }
        }
    }
}


struct uploadCart: Codable{
    internal init(cart_id: Int, items: [ItemAfterEditing]) {
        self.cart_id = cart_id
        self.items = items
    }
    
    let cart_id:Int
    let items: [ItemAfterEditing]
}
struct ItemAfterEditing : Codable{
    internal init(product_id: String, product_weight_unit_id: String, quantity: String) {
        self.product_id = product_id
        self.product_weight_unit_id = product_weight_unit_id
        self.quantity = quantity
    }
    
    let product_id,product_weight_unit_id,quantity: String
    
}
