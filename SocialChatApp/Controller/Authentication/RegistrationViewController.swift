//
//  RegistrationViewController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/23.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController
{
    
    private var viewModel = regisrtionValidation()
    
    var emailuser = UITextField()
    var usernameuser = UITextField()
    var passworduser = UITextField()
    var fullnameuser = UITextField()
    
    private let photoaddPlusButton: UIButton =
    {
        let button = UIButton(type:.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.setDimensions(height: 200, width: 200)
        button.clipsToBounds = true
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    
    fileprivate lazy var emailContainerView: UIView =
    {
        let emailtextfield = myCustomTextField(identifier: "Email")
        let view = CustomTextfield(Image: UIImage(systemName: "envelope.fill") ?? UIImage(), myemailField: emailtextfield)
        emailuser = emailtextfield
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeight(height: 50)
        return view
    }()
    
    fileprivate lazy var fullname: UIView =
    {
        let fulllnametextfield = myCustomTextField(identifier: "Fullname")
        let view = CustomTextfield (Image: UIImage(systemName: "person.badge.plus") ?? UIImage(),myemailField: fulllnametextfield)
        fullnameuser = fulllnametextfield
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeight(height: 50)
        return view
    }()
    
    fileprivate lazy var username: UIView =
    {
        let usernametextfield = myCustomTextField(identifier: "Username")
        let view = CustomTextfield (Image: UIImage(systemName: "person.badge.plus") ?? UIImage(),myemailField: usernametextfield)
        usernameuser = usernametextfield
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeight(height: 50)
        return view
    }()
    
    
    fileprivate lazy var passwordContainerView: UIView =
    {
        
        let passwordTextfield = myCustomTextField(identifier: "Password")
        let view = CustomTextfield(Image: UIImage(systemName: "lock.fill") ?? UIImage(), myemailField:passwordTextfield)
        passworduser = passwordTextfield
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeight(height: 50)
        return view
    }()
    
    
    fileprivate let Signup: UIButton =
    {
        let button = CustomButton(titleButton: "Sign up", backgrouncColor: UIColor.systemRed)
        return button
    }()
    
    
    fileprivate let signUpButtonPressed: UIButton =
    {
        let button = buttonText(firsttext: "You have an account? ", secondText: "Login")
        return button
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        handleButtonSignupview()
        configurationUI()
        configureViews()
        handletextfields()
    }
    
    func configureViews()
    {
        view.addSubview(photoaddPlusButton)
        
        let logoImageContraints = [photoaddPlusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                   photoaddPlusButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(logoImageContraints)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,fullname,username,passwordContainerView,Signup])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        
        let stackViewContraints = [stack.topAnchor.constraint(equalTo: photoaddPlusButton.bottomAnchor, constant: 30),
                                   stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
                                   stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10)]
        
        NSLayoutConstraint.activate(stackViewContraints)
        
        view.addSubview(signUpButtonPressed)
        
        signUpButtonPressed.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        signUpButtonPressed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    fileprivate func handletextfields()
    {
        emailuser.addTarget(self,action: #selector(handleAction), for: .editingChanged)
        usernameuser.addTarget(self,action: #selector(handleAction), for: .editingChanged)
        passworduser.addTarget(self,action: #selector(handleAction), for: .editingChanged)
        fullnameuser.addTarget(self,action: #selector(handleAction), for: .editingChanged)
    }
    
    
    @objc func handleAction(textfield: UITextField)
    {
        if textfield == emailuser
        {
            viewModel.email = textfield.text
        
        }else if textfield == usernameuser
        {
            viewModel.username = textfield.text
            
        }else if textfield == fullnameuser
        {
            viewModel.fullName = textfield.text
        }else
        {
            viewModel.password = textfield.text
        }
        checkstatus()
    }
    
    
    
    func checkstatus()
    {
        if viewModel.formisValid
        {
            Signup.isEnabled = true
            Signup.backgroundColor  = .systemBackground
        }else
        {
            Signup.isEnabled = false
            Signup.backgroundColor = UIColor.systemPink.withAlphaComponent(0.80)
        }
    }
    
    func handleButtonSignupview()
    {
        signUpButtonPressed.addTarget(self, action: #selector(handleLoginView), for: .touchUpInside)
        Signup.addTarget(self, action: #selector(hanglesignup), for: .touchUpInside)
        photoaddPlusButton.addTarget(self, action: #selector(handlePhotoplus), for: .touchUpInside)
    }
    
    @objc func handleLoginView()
    {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func hanglesignup()
    {
    
        print("DEBUG: SIGNUP")
    }
    
    @objc func handlePhotoplus()
    {
        let imagepickerController = UIImagePickerController()
        imagepickerController.delegate = self
        self.present(imagepickerController, animated: true, completion: nil)
    }
    
}

extension RegistrationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        
        photoaddPlusButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        photoaddPlusButton.layer.borderColor = UIColor.white.cgColor
        photoaddPlusButton.layer.borderWidth = 2
        photoaddPlusButton.layer.cornerRadius = 200 / 2
       
        self.dismiss(animated: true, completion: nil)
    }
}
