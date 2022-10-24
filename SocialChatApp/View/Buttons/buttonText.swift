//
//  buttonText.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/23.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class buttonText: UIButton
{
    
    init(firsttext: String , secondText: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        let attributed = NSAttributedString(string: secondText, attributes: [.foregroundColor:UIColor.white,.font:UIFont.boldSystemFont(ofSize: 12)])
        let attributedArray = NSMutableAttributedString(string: firsttext, attributes: [.foregroundColor:UIColor.init(white: 1, alpha: 0.67),.font:UIFont.systemFont(ofSize: 14)])
        attributedArray.append(attributed)
        self.setAttributedTitle(attributedArray, for: .normal)
        self.setTitleColor(.init(white: 1, alpha: 0.67), for: .normal)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
