//
//  DetailViewController.swift
//  Formulario
//
//  Created by Antonio Flores on 24/09/17.
//  Copyright © 2017 Antonio Flores. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var index = 0
    
    @IBOutlet weak var nombre: UILabel!
    @IBOutlet weak var apellidos: UILabel!
    @IBOutlet weak var direccion: UILabel!
    @IBOutlet weak var telefono: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var fechaNacimiento: UILabel!
    @IBOutlet weak var estadoCivil: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setInfo(){
        
        let realm = try! Realm()
        let thePerson = realm.objects(Person.self)
        
        nombre.text = "Nombre: " + thePerson[index].nombre
        apellidos.text = "Apellidos: " + thePerson[index].apellidos
        direccion.text = "Direccíon: " + thePerson[index].direccion
        telefono.text = "Telefono: " + thePerson[index].telefono
        email.text = "Email: " + thePerson[index].email
        fechaNacimiento.text = "Fecha de Nacimiento: " + thePerson[index].fechaNacimiento
        estadoCivil.text = "Estado Civil: " + thePerson[index].estadoCivil
    }
}
