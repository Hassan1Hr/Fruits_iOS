//
//  CashedData.swift
//
//
//  Created by Hassan Ramadan on 9/25/19.
//  Copyright © 2019 Hassan Ramadan. All rights reserved.
//

import Foundation

class CashedData: NSObject  {
    class func saveUserRegionName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "RegionName")
        def.synchronize()
    }
    class  func getUserRegionName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "RegionName") as? String)
    }
    class func saveUserRegionId(name:Int){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "RegionId")
        def.synchronize()
    }
    class  func getUserRegionId ()->Int? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "RegionId") as? Int)
    }
    class func saveUserCityName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "CityName")
        def.synchronize()
    }
    class  func getUserCityName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "CityName") as? String)
    }
    class func saveUserCityId(name:Int){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "CityId")
        def.synchronize()
    }
    class  func getUserCityId ()->Int? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "CityId") as? Int)
    }
    class func saveUserApiKey(token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "token")
        def.synchronize()
    }
    class  func getUserApiKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "token") as? String)
    }
    class func saveUserUpdateKey (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "UserUpdateApiKey")
        def.synchronize()
    }
    class  func getUserUpdateKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserUpdateApiKey") as? String)
    }
    class func saveUserName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserName")
        def.synchronize()
    }
    class  func getUserName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserName") as? String)
    }
    
    class func saveUserPhone (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserPhone")
        def.synchronize()
    }
    class func getUserPhone ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserPhone") as? String)
    }
    class func saveUserImage (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserImage")
        def.synchronize()
    }
    
    class  func getUserImage ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserImage") as? String)
    }
    class func saveUserEmail (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserEmail")
        def.synchronize()
    }
    class  func getUserEmail ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserEmail") as? String)
    }
    class func saveUserPassword (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserPassword")
        def.synchronize()
    }
    class  func getUserPassword ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserPassword") as? String)
    }
    
    class func saveUserID (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "UserID")
        def.synchronize()
    }
    class  func getUserID ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "UserID") as? String)
    }
    // for admin
    class func saveAdminApiKey (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "AdminApiKey")
        def.synchronize()
    }
    class  func getAdminApiKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminApiKey") as? String)
    }
    
    class func saveAdminCityId (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "AdminCityId")
        def.synchronize()
    }
    class  func getAdminCityId ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminCityId") as? String)
    }
    
    class func saveAdminUpdateKey (token:String){
        let def = UserDefaults.standard
        def.setValue(token , forKey: "AdminUpdateApiKey")
        def.synchronize()
    }
    class  func getAdminUpdateKey ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminUpdateApiKey") as? String)
    }
    
    class func saveAdminName (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminName")
        def.synchronize()
    }
    class func getAdminName ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminName") as? String)
    }
    
    
    class func saveAdminImage (name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminImage")
        def.synchronize()
    }
    class  func getAdminImage ()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminImage") as? String)
    }
    
    class func saveAdminID (name:Int){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminID")
        def.synchronize()
    }
    class  func getAdminID ()->Int? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminID") as? Int)
    }
    
    class func saveAdminPassword(name:String){
        let def = UserDefaults.standard
        def.setValue(name , forKey: "AdminPassword")
        def.synchronize()
    }
    class func getAdminPassword()->String? {
        let dif = UserDefaults.standard
        return (dif.object(forKey : "AdminPassword") as? String)
    }
    

}
