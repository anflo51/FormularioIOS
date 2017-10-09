//
//  ViewController.swift
//  Formulario
//
//  Created by Antonio Flores on 24/09/17.
//  Copyright © 2017 Antonio Flores. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var apellido: UITextField!
    @IBOutlet weak var direccion: UITextField!
    @IBOutlet weak var telefono: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var estadoCivil: UIPickerView!
    
    
    @IBOutlet weak var nombreUsuario: UITextField!
    @IBOutlet weak var contrasena: UITextField!
    @IBOutlet weak var guardar: UIButton!
    
    var arrayPicker = ["Soltero","Casado","Separado","Divorciado","Viudo"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        
        self.estadoCivil.dataSource = self
        self.estadoCivil.delegate = self
        
        self.telefono.delegate = self
        
        //print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @available(iOS 2.0, *)
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayPicker.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayPicker[row]
    }
    
    @IBAction func guardarAction(_ sender: Any) {
        
        if nombre.text!.isEmpty || apellido.text!.isEmpty || direccion.text!.isEmpty
            || telefono.text!.isEmpty || email.text!.isEmpty || nombreUsuario!.text!.isEmpty
            || contrasena.text!.isEmpty {
            self.showToast(message: "Todos los campos son requeridos")
        }else{
            let emailString = email.text ?? "nt"
            
            if emailString.isEmail {
                saveRealm()
            }else{
                self.showToast(message: "Email no valido")
            }
            
        }
    }
    
    func saveRealm(){
        let thePerson = Person()
        thePerson.nombre = nombre.text ?? "nt"
        thePerson.apellidos = apellido.text ?? "nt"
        thePerson.direccion = direccion.text ?? "nt"
        thePerson.telefono = telefono.text ?? "nt"
        thePerson.email = email.text ?? "nt"
        thePerson.nombreUsuario = nombreUsuario.text ?? "nt"
        thePerson.contrasena = contrasena.text ?? "nt"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateString = dateFormatter.string(from: datePicker.date)
        thePerson.fechaNacimiento = dateString
        
        let rowPickerView = self.estadoCivil.selectedRow(inComponent: 0)
        thePerson.estadoCivil = arrayPicker[rowPickerView]
        
        let realm = try! Realm()
        try! realm.write() {
            realm.add(thePerson)
            self.showToast(message: "La información ha sido guardada")
        }
    }
    
    func clear(){
        nombre.text = ""
        apellido.text = ""
        direccion.text = ""
        telefono.text = ""
        email.text = ""
        nombreUsuario.text = ""
        contrasena.text = ""
    }
    
    //El UITextField de numero telefonico solo admite numeros
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789qQ").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    func validateContrasenaLength(_ contrasena: String) -> Bool{
        if contrasena.characters.count > 5 {
            return true
        }else{
            return false
        }
    }
    
    func nameForImage() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let info = String(calendar.component(.day, from: date))+String(calendar.component(.month, from: date))+String(calendar.component(.hour, from: date))+String(calendar.component(.second, from: date))
        
        return info
    }
}

