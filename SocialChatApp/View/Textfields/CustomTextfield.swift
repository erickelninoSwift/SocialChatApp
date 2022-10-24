//
//  CustomTextfield.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/23.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class CustomTextfield: UIView
{
    
    init(Image: UIImage, myemailField: myCustomTextField) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let imageicone: UIImageView =
        {
            let erickimage = UIImageView()
            erickimage.translatesAutoresizingMaskIntoConstraints = false
            erickimage.image = Image
            erickimage.setDimensions(height: 20, width: 20)
            erickimage.contentMode = .scaleAspectFill
            erickimage.tintColor = .white
            return erickimage
            
        }()
        
    
        
        
        let linebutton: UIView =
        {
            let myline = UIView()
            myline.translatesAutoresizingMaskIntoConstraints = false
            myline.backgroundColor = .init(white: 1, alpha: 0.67)
            myline.heightAnchor.constraint(equalToConstant: 1).isActive = true
            return myline
        }()
        
        func configireUItextfield()
        {
            self.addSubview(imageicone)
            self.addSubview(myemailField)
            self.addSubview(linebutton)
            
            imageicone.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
            imageicone.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            myemailField.leadingAnchor.constraint(equalTo: imageicone.trailingAnchor, constant: 5).isActive = true
            myemailField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            
            linebutton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            linebutton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            linebutton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            
        }
        
        configireUItextfield()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

