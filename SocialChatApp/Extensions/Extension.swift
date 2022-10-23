//
//  Extension.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/09/30.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit


extension UIViewController
{
    func configurationUI()
    {
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor.systemPurple.cgColor,UIColor.systemRed.cgColor]
        layerGradient.locations = [0,1]
        view.layer.addSublayer(layerGradient)
        layerGradient.frame = view.frame
    }
    
    func configurationHeaderTitleView(title: String , mybackgroundColor: UIColor)
    {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor:UIColor.white]
        appearance.backgroundColor = mybackgroundColor
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        
        
        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
        view.backgroundColor = .white
        
    }
    
}
