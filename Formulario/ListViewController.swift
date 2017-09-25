//
//  ListViewController.swift
//  Formulario
//
//  Created by Antonio Flores on 24/09/17.
//  Copyright © 2017 Antonio Flores. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var personList : Results<Person>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        personList = realm.objects(Person.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NameTableViewCell
        cell.nombre.text = personList[indexPath.row].nombre + " " + personList[indexPath.row].apellidos
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detail.index = indexPath.row
        self.navigationController?.pushViewController(detail, animated: true)
    }
}
