//
//  ContentViewController.swift
//  slideMenuStarter
//
//  Created by Bassam Ramadan on 4/16/20.
//  Copyright © 2020 fluffy. All rights reserved.
//

import UIKit

class ContentViewController: common {
    
    var MenuButton: UIButton!
    var CartButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuButton = setupButton(imageName: "ic_menu")
        CartButton = setupButton(imageName: "ic_cart")
        
        // function performed when the button is tapped
        MenuButton.addTarget(self, action: #selector(handleSetting(_:)), for: .touchUpInside)
        CartButton.addTarget(self, action: #selector(handleCart(_:)), for: .touchUpInside)
        // Add the profile button as the left bar button of the navigation bar
        let Rightbutton = UIBarButtonItem(customView: MenuButton)
        self.navigationItem.rightBarButtonItem = Rightbutton
        
        
        let Leftbutton = UIBarButtonItem(customView: CartButton)
        self.navigationItem.setLeftBarButton(Leftbutton, animated: true)
        
        
    }
    func setupButton(imageName: String) -> UIButton{
        let MenuButton = UIButton(type: .system)
        MenuButton.setImage(UIImage(named: imageName) , for: .normal)
        MenuButton.contentMode = .scaleAspectFit
        MenuButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            MenuButton.widthAnchor.constraint(equalToConstant: 35.0),
            MenuButton.heightAnchor.constraint(equalToConstant: 35.0)
            ])
        
        return MenuButton
    }
    @objc func handleCart(_ recognizer: UIPanGestureRecognizer){
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "Cart") as! UINavigationController
        self.present(linkingVC, animated: true)
    }
    @objc func handleSetting(_ recognizer: UIPanGestureRecognizer){
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        let linkingVC = storyboard.instantiateViewController(withIdentifier: "Setting") as! UINavigationController
        self.present(linkingVC, animated: true)
    }
    func getCartItems(id:Int){
        getCartItems{
            (data) in
            self.CartButton.addBadge(id: id, number: data?.items?.count ?? 0, withOffset: CGPoint(x: -6, y: -3), andBackgroundColor: .red, strokeColor: UIColor.white, textColor:
                UIColor.white)
        }
    }
}
