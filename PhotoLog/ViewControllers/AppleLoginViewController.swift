//
//  AppleLoginViewController.swift
//  PhotoLog
//
//  Created by Lio on 2022/12/12.
//

import UIKit
import AuthenticationServices

class AppleLoginViewController: UIViewController, ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var loginAppleStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupProviderLoginView()
        
        checkAutoLogin()
    }
    
    func checkAutoLogin() {
        // 값이 저장되어있다면 자동 로그인
        guard let uid = UserDefaults.standard.string(forKey: "uid") else {
            return
        }
        if login(uid: uid){
            showNextPage()
        } else {
            // 사용자 정보 없음 새로 로그인 요청
        }
    }
    
    func login(uid : String)-> Bool {
        // 로그인 서버통신 후 사용자 정보 가져오기
        return true
    }
    
    func showNextPage() {
        
    }
    
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginAppleStackView.addArrangedSubview(authorizationButton)
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    // Apple ID 연동 성공 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
            // Apple ID
            case let appleIDCredential as ASAuthorizationAppleIDCredential:
                
                // 계정 정보 가져오기
                let userIdentifier = appleIDCredential.user
                let fullName = appleIDCredential.fullName
                let email = appleIDCredential.email
                
                let name = (fullName?.givenName ?? "") + (fullName?.familyName ?? "")
                let mail = email ?? ""
                
                UserDefaults.standard.set(userIdentifier, forKey: "uid")
                UserDefaults.standard.set(name, forKey: "name")
                UserDefaults.standard.set(mail, forKey: "email")
                UserDefaults.standard.set(true, forKey: "autoLogin")
                
                print("User ID : \(userIdentifier)")
                print("User Email : \(mail)")
                print("User Name : \(name)")
                
                showNextPage()
                
            default:
                UserDefaults.standard.set(false, forKey: "autoLogin")
                break
        }
    }
    
    // Apple ID 연동 실패 시
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Apple Login Error : \(error)")
    }
}

