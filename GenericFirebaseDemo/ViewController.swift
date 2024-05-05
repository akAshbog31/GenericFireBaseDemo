//
//  ViewController.swift
//  GenericFirebaseDemo
//
//  Created by Nexios Mac 4 on 08/04/24.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    // MARK: - @IBOutlets
    @IBOutlet weak var lblName: UILabel!
    
    // MARK: - Properties
    let firebaseServices: FireBaseServices = FireBaseManager()
    
    // MARK: - Life-Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        createUser()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//            self.getAllUser()
//        }
//        getUser()
        
        getUserName()
    }
    
    // MARK: - @IBActions
    
    // MARK: - Fuctions
    @MainActor
    func createUser() {
        Task {
            do {
                let userModel = try await firebaseServices.signUp(with: "akashboghani6@gmail.com", password: "Test@123")
                try await firebaseServices.createUser(for: UserModel(id: userModel.id, name: "Akash Patel6", email: userModel.email, createdAt: userModel.createdAt))
            } catch let error as FireBaseError {
                print(error.description)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getAllUser() {
        Task {
            do {
                let arrUserModel = try await firebaseServices.getAllUser()
                print(arrUserModel)
            } catch let error as FireBaseError {
                print(error.description)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func getUser() {
        Task {
            do {
                let arrUserModel = try await firebaseServices.getUser(for: Auth.auth().currentUser?.uid ?? "")
                print(arrUserModel)
            } catch let error as FireBaseError {
                print(error.description)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getUserName() {
        firebaseServices.getUserName { result in
            switch result {
            case .success(let success):
                do {
                    let model: UserModel = try Parser.parse(success)
                    self.lblName.text = model.name
                } catch let error as FireBaseError {
                    print(error.description)
                } catch {
                    print(error.localizedDescription)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

