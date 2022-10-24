//
//  FromValidation.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/24.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import Foundation

struct FromValidation
{
    var email:String?
    var password:String?
    
    var formisValid:Bool
    {
        guard let myemail = email ,let mypassword = password else {return false}
        
        return !myemail.isEmpty && !mypassword.isEmpty
    }
}

struct regisrtionValidation
{
    var email:String?
    var password:String?
    var username:String?
    var fullName:String?
    
    
    var formisValid:Bool
    {
        guard let myemail = email ,let mypassword = password , let myusername = username , let myfullName = fullName else {return false}
        
        return !myemail.isEmpty && !mypassword.isEmpty && !myusername.isEmpty && !myfullName.isEmpty
    }
}




