//
//  CreateViewController.swift
//  CoreDataTest
//
//  Created by 양수빈 on 2022/11/07.
//

import UIKit

import CoreData

class CreateViewController: UIViewController {
    var container: NSPersistentContainer!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var data: PhoneBook!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var memoTextField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.container = appDelegate.persistentContainer
        
        if data != nil {
            self.nameTextField.text = data.personName
            self.phoneTextField.text = data.phoneNumber
            self.memoTextField.text = data.memo
            self.actionButton.setTitle("저장하기", for: .normal)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        if data == nil {
            createContact()
        } else {
            updateContact()
        }
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func createContact() {
        // entity 가져옴
        let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: self.container.viewContext)
        
        // NSManagedObject 생성
        let person = NSManagedObject(entity: entity!, insertInto: self.container.viewContext)
        person.setValue(memoTextField.text, forKey: "memo")
        person.setValue(nameTextField.text, forKey: "personName")
        person.setValue(phoneTextField.text, forKey: "phoneNumber")
        
        do {
            try self.container.viewContext.save()
            self.dismiss(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateContact() {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "PhoneBook")
        fetchRequest.predicate = NSPredicate(format: "personName = %@", data.personName!)

        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(memoTextField.text, forKey: "memo")
            objectUpdate.setValue(nameTextField.text, forKey: "personName")
            objectUpdate.setValue(phoneTextField.text, forKey: "phoneNumber")
            
            do {
                try managedContext.save()
                self.dismiss(animated: true)
            } catch {
                print(error.localizedDescription)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
