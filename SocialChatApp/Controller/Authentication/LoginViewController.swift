//
//  LoginViewController.swift
//  SocialChatApp
//
//  Created by Erick El nino on 2022/10/22.
//  Copyright © 2022 Erick El nino. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    //    MARK: - Properties
    
    var myemailtextfield = UITextField()
    var mypasswordTextfield = UITextField()
    
    private var ViewModel = FromValidation()
    
     let logoImage: UIImageView =
    {
        let logo = UIImageView()
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(systemName:"message")
        logo.setDimensions(height: 130, width: 130)
        logo.tintColor = .white
        
        return logo
    }()
    
    
     lazy var emailContainerView: UIView =
    {
        let emailtextField = myCustomTextField(identifier: "Email")
        let view = CustomTextfield(Image: UIImage(systemName: "envelope.fill") ?? UIImage(), myemailField: emailtextField)
        emailtextField.addTarget(self, action: #selector(editingChange), for: .editingChanged)
        myemailtextfield = emailtextField
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeight(height: 50)
        return view
    }()
    
    
     lazy var passwordContainerView: UIView =
    {
        let passwordfield = myCustomTextField(identifier: "Password")
        let view = CustomTextfield(Image: UIImage(systemName: "lock.fill") ?? UIImage(),myemailField: passwordfield)
        passwordfield.addTarget(self, action: #selector(editingChange), for: .editingChanged)
        mypasswordTextfield = passwordfield
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setHeight(height: 50)
        return view
    }()
    
    
     let loginButton: UIButton =
    {
        let button = CustomButton(titleButton: "Log In", backgrouncColor: UIColor.systemRed)
        return button
    }()
    
    
    
     let signUpButtonPressed: UIButton =
    {
        let button = buttonText(firsttext: "Don't have an account? ", secondText: "Sign Up")
        
        return button
    }()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        buttonPressed()
        configurationUI()
        configureViews()
        textFieldTarget()
    }
    
    
    
    //    MARK: - LifeCycle
    
    func configureViews()
    {
        view.addSubview(logoImage)
        
        let logoImageContraints = [logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                                   logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(logoImageContraints)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 16
        
        view.addSubview(stack)
        
        let stackViewContraints = [stack.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 30),
                                   stack.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 10),
                                   stack.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -10)]
        
        NSLayoutConstraint.activate(stackViewContraints)
        
        view.addSubview(signUpButtonPressed)
        
        signUpButtonPressed.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        signUpButtonPressed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    //    MARK: - Functions
    
    @objc func editingChange(textfield: UITextField)
    {
        if textfield == myemailtextfield
        {
            ViewModel.email = textfield.text
        
        }else
        {
            ViewModel.password = textfield.text
        }
        checkstatus()
    }
    
    func checkstatus()
    {
        if ViewModel.formisValid
        {
            loginButton.isEnabled = true
            loginButton.backgroundColor  = .systemBackground
        }else
        {
            loginButton.isEnabled = false
            loginButton.backgroundColor = UIColor.systemPink.withAlphaComponent(0.80)
        }
    }
    
    func buttonPressed()
    {
        loginButton.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        signUpButtonPressed.addTarget(self, action: #selector(handleSignupbutton), for: .touchUpInside)
        
    }
    
    func textFieldTarget()
    {
        print(emailContainerView)
        print(passwordContainerView)
    }
    
    
    
    @objc func handleLoginButton()
    {
        print("DEBUG: LOGIN PRESSED")
    }
    
    @objc func handleSignupbutton()
    {
        navigationController?.pushViewController(RegistrationViewController(), animated: true)
    }
}
