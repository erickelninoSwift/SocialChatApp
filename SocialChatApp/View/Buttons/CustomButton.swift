//
//  CustomButton.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/23.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class CustomButton: UIButton
{
    init(titleButton: String, backgrouncColor: UIColor) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(titleButton, for: .normal)
        self.backgroundColor = backgrouncColor.withAlphaComponent(0.2)
        self.layer.cornerRadius = 5
        self.setHeight(height: 50)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

