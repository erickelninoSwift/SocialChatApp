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
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        let layerGradient = CAGradientLayer()
        layerGradient.colors = [UIColor.systemPurple.cgColor,UIColor.systemRed.cgColor]
        layerGradient.locations = [0,1]
        view.layer.addSublayer(layerGradient)
        layerGradient.frame = view.frame
    }
    
}
