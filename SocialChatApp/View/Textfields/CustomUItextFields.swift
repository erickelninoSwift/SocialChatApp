//
//  CustomUItextFields.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/24.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class myCustomTextField: UITextField
{
      init(identifier: String) {
        super.init(frame: .zero)
        
       
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = .white
        if identifier == "Password"
        {
            self.isSecureTextEntry = true
        }else
        {
            self.isSecureTextEntry = false
        }
        self.borderStyle = .none
        let attribured = NSAttributedString(string: identifier, attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.57)])
        self.attributedPlaceholder = attribured
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
