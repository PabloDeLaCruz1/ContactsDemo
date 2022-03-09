//
//  ViewController.swift
//  ContactsDemo
//
//  Created by Pablo De La Cruz on 3/7/22.
//

import UIKit
import Contacts

class ViewController: UITableViewController {

    var cont = [ContactDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getContacts()
    }

    func getContacts() {
        let cn = CNContactStore()
        cn.requestAccess(for: .contacts) { granted, err in
            if let er = err {
                print(er)
                return
            }
            if granted {
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let req = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                do {
                    try cn.enumerateContacts(with: req, usingBlock: { (contact, status) in

                        self.cont.append(ContactDetails(fname: contact.givenName, lname: contact.familyName, tNum: contact.phoneNumbers.first?.value.stringValue ?? ""))
                    })
                } catch {

                }
            }

        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cont.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = cont[indexPath.row].fname + " " + cont [indexPath.row].lname
        
            return cell
    }
}

