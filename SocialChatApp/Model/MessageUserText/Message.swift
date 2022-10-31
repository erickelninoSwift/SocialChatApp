//
//  Message.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/30.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation
import Firebase

struct Message
{
    let text:String
    let toID:String
    let fromID:String
    var time: Timestamp!
    var user: User?
    var isfromCurrentUser:Bool
    
    
    init(userdata: [String:Any]) {
        
        self.text = userdata["message"] as? String ?? ""
        self.toID = userdata["toId"] as? String ?? ""
        self.fromID = userdata["fromId"] as? String ?? ""
        self.time = userdata["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.isfromCurrentUser = fromID == Auth.auth().currentUser?.uid
    }
}
