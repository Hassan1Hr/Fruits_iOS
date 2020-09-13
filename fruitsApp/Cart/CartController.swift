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
            data?.items?[sender.tag].quantity = "\((Int(data?.items?[sender.tag].quantity ?? "0") ?? 0) + 1)"
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
            data?.items?[sender.tag].quantity = "\((Int(data?.items?[sender.tag].quantity ?? "0") ?? 0) - 1)"
            self.cartItemCollection.reloadData()
        }
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
        cell.quantity.text = item?.quantity ?? "0"
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
    internal init(product_id: Int, product_weight_unit_id: Int, quantity: Int) {
        self.product_id = product_id
        self.product_weight_unit_id = product_weight_unit_id
        self.quantity = quantity
    }
    
    let product_id,product_weight_unit_id,quantity: Int
    
}
