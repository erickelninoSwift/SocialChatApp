//
//  APICaller.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/25.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit
import Firebase

struct userCredentials
{
    let email: String
    let password: String
    let username:String
    let fullname:String
    let profilepicImage:UIImage

}

class APICaller
{
    static let shared = APICaller()
    
//
    
    func registrationUser(currentUser: userCredentials , CurrentViewController: UIViewController)
    {
        guard let imagetoSave = currentUser.profilepicImage.jpegData(compressionQuality: 0.4) else {return}
            
            
            let storageImagePath = Storage.storage().reference()
            let fileName = NSUUID().uuidString
            
            let filelocation = storageImagePath.child("profile_images/\(fileName)")
            
              filelocation.putData(imagetoSave, metadata: nil) { (meta, Error) in
            
                if let error  = Error
                {
                    print("DEBUG: Image could not be save with error \(error.localizedDescription)")
                }else
                {
        
                     filelocation.downloadURL { (url, error) in
                        if error != nil
                        {
                            print("There was an error while trying to reteive file URL with error \(error!.localizedDescription)")
                        }else
                        {
                            guard let imageDownloadURL = url?.absoluteString else {return}
                              print("Image URL \(imageDownloadURL)")
                                
                            Auth.auth().createUser(withEmail: currentUser.email, password: currentUser.password) { (Results, Error) in
                                      if Error != nil
                                      {
                                          print("There was an Error while trying to Register user \(Error?.localizedDescription ?? "")")
                                      }else
                                      {
                                          print("User was registered Successfully\(Results?.user.email ?? "")")
                                          
                                          guard let uui = Results?.user.uid else { return }
                                          
                                        let data = ["email": currentUser.email , "fullname":currentUser.fullname , "profileImageUrl":imageDownloadURL,"uid": uui , "username": currentUser.username] as [String:Any]
                                          
                                          Firestore.firestore().collection("USERS").document(uui).setData(data) { (Error) in
                                              if Error != nil
                                              {
                                                  print("There was an error while saving user informations into the datastore \(Error?.localizedDescription ?? "")")
                                                  return
                                              }else
                                              {
                                                  print("DEBUG: Did Create users")
                                                  CurrentViewController.dismiss(animated: true, completion: nil)
                                              }
                                          }
                                          
                                      }
                                  }
                          
                        }
                    }
                }
            }
    }
    
    func login(emailadress: String, password: String , with currentViewController: UIViewController)
    {
        Auth.auth().signIn(withEmail: emailadress, password: password) { (Resluts, Error) in
            if Error != nil
            {
                print("There was an error while trying to loggin \(Error!.localizedDescription)")
            }else
            {
                currentViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}



//    func registerUSer(email: String,password:String ,imageURL: String ,fullname:String, username:String, Controller: UIViewController)
//    {
//        Auth.auth().createUser(withEmail: email, password: password) { (Results, Error) in
//            if Error != nil
//            {
//                print("There was an Error while trying to Register user \(Error?.localizedDescription ?? "")")
//            }else
//            {
//                print("User was registered Successfully\(Results?.user.email ?? "")")
//
//                guard let uui = Results?.user.uid else { return }
//
//                let data = ["email": email , "fullname":fullname , "profileImageUrl":imageURL,"uid": uui , "username": username] as [String:Any]
//
//                Firestore.firestore().collection("USERS").document(uui).setData(data) { (Error) in
//                    if Error != nil
//                    {
//                        print("There was an error while saving user informations into the datastore \(Error?.localizedDescription ?? "")")
//                        return
//                    }else
//                    {
//                        print("DEBUG: Did Create users")
//                        Controller.dismiss(animated: true, completion: nil)
//                    }
//                }
//
//            }
//        }
//    }
//    
