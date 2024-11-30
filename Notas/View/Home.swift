//
//  Home.swift
//  Notas
//
//  Created by Bresnier Moreno on 21/12/2022.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>
    
//    @FetchRequest(entity: Notas.entity(), sortDescriptors: [],
//                  predicate: NSPredicate(format: "nota CONTAINS[c] 'IMPORTANTE'"),
//                  animation: .spring()) var results : FetchedResults<Notas>
    
    var body: some View {
        NavigationView{
            List{
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action:{
                            model.sendData(item: item)
                        }){
                            Label(title:{
                                Text("Editar")
                            }, icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action:{
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Eliminar")
                            }, icon:{
                                Image(systemName: "trash")
                            })
                        }
                    }))
                }
            }
            .navigationBarTitle("Notas")
            .navigationBarItems(trailing:
                                    Button(action:{
                                        model.show.toggle()
                                    }){
                                        Image(systemName: "plus")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
            ).sheet(isPresented: $model.show, content: {
                AddView(model: model)
            })
        }
    }
}


