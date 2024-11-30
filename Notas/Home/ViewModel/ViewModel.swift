//
//  ViewModel.swift
//  Notas
//
//  Created by Bresnier Moreno on 21/12/22.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    @Published var tipo = ""
    // CoreData
    
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha

        do {
            try context.save()
            print("guardo")
            show.toggle()
        } catch let error as NSError {
            print("No guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item:Notas,context: NSManagedObjectContext){
        context.delete(item)
        //try! context.save()
        do {
            try context.save()
            print("Elimino")
        } catch let error as NSError {
            print("No elimino", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas){
        updateItem = item
       
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("edito")
            show.toggle()
        } catch let error as NSError {
            print("No edito", error.localizedDescription)
        }
    }
    
}
