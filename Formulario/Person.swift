//
//  Person.swift
//  Formulario
//
//  Created by Antonio Flores on 24/09/17.
//  Copyright © 2017 Antonio Flores. All rights reserved.
//

import RealmSwift

class Person: Object {
    dynamic var nombre = ""
    dynamic var apellidos = ""
    dynamic var direccion = ""
    dynamic var telefono = ""
    dynamic var email = ""
    dynamic var fechaNacimiento = ""
    dynamic var estadoCivil = ""
    dynamic var nombreUsuario = ""
    dynamic var contrasena = ""
}
