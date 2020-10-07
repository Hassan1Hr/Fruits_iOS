//
//  orders.swift
//  fruitsApp
//
//  Created by Bassam Ramadan on 10/2/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit

class myOrders: common {

    @IBOutlet var myOrdersCollection: UICollectionView!
    
    var myOrdersData = [orderData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "طلباتي"
        setupBackButtonWithDismiss()
        getOrders()
    }
    func getOrders(){
        self.loading()
        let url = AppDelegate.LocalUrl + "my-orders"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
            "Authorization" : "Bearer " + (CashedData.getUserApiKey() ?? "")
        ]
        
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil {
                    if success {
                        let dataReceived = try decoder.decode(orders.self, from: jsonData)
                        self.myOrdersData.removeAll()
                        self.myOrdersData.append(contentsOf: dataReceived.data ?? [])
                        self.myOrdersCollection.reloadData()
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
    @IBAction func sendReceipt(sender: UIButton!){
        self.loading()
        let url = AppDelegate.LocalUrl + "send-receipt/\(sender.tag)"
        let headers = [
            "Content-Type": "application/json" ,
            "Accept" : "application/json",
            "Authorization" : "Bearer " + (CashedData.getUserApiKey() ?? "")
        ]
        
        AlamofireRequests.getMethod(url: url, headers: headers){
            (error, success, jsonData) in
            do {
                let decoder = JSONDecoder()
                if error == nil{
                    let dataRecived = try decoder.decode(receipt.self, from: jsonData)
                    self.present(common.makeAlert(message: dataRecived.message ?? ""), animated: true, completion: nil)
                    self.stopAnimating()
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
extension myOrders: UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myOrdersData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myOrders", for: indexPath) as! myOrdersCell
        let data = myOrdersData[indexPath.row]
        cell.bill.tag = data.id ?? 0
        cell.number.text = "\(data.id ?? 0)"
        cell.date.text = data.createdAt ?? ""
        cell.cost.text = data.totalCost ?? "0"
        if data.status ?? "" != "preview"{
            cell.status = data.status ?? ""
        }
        return cell
    }
}
