//
//  User.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/28.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

struct User:Codable
{
    let email:String
    let fullname:String
    let profileImageUrl:String
    let uuid: String
    let username: String
    
    init(userdata: [String:Any]) {
        
        self.username = userdata["username"] as? String ?? ""
        self.email = userdata["email"] as? String ?? ""
        self.profileImageUrl = userdata["profileImageUrl"] as? String ?? ""
        self.uuid = userdata["uid"] as? String ?? ""
        self.fullname = userdata["fullname"] as? String ?? ""
    }
}
