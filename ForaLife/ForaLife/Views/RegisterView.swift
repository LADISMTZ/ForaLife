//
//  RegisterView.swift
//  ForaLife
//
//  Created by Fernando Ahuatzin Gallardo on 15/06/23.
//

import SwiftUI

struct RegisterView: View {
    @State var username: String = ""
    @State var password: String = ""
    @State var confirmedPassword: String = ""
    @State var street: String = ""
    @State var number: String = ""
    @State var city: String = ""
    @State var zip: String = ""
    @State var correctRegister: Bool = false
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color(hue: 0.374, saturation: 0.846, brightness: 0.426)
                    .ignoresSafeArea()
                Circle()
                    .scale(2)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white)
                VStack(alignment: .center) {
                    
                    Text("Datos de la cuenta")
                        .bold()
                        .padding()
                        .font(.largeTitle)
                    
                    TextField("Usuario", text: $username)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    
                    SecureField("Contraseña", text: $password)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                   
                    SecureField("Confirmar contraseña", text: $confirmedPassword)
                        .padding()
                        .frame(width:300, height:50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Text ("Dirección")
                        .bold()
                        .padding()
                        .font(.largeTitle)
                    HStack {
                        TextField("Calle", text: $street)
                            .padding()
                            .frame(width:200, height:50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        TextField("Número", text: $number)
                            .padding()
                            .frame(width:100, height:50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        
                    }
                    HStack {
                        TextField("Ciudad", text: $city)
                            .padding()
                            .frame(width:150, height:50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        TextField("Código postal", text: $zip)
                            .padding()
                            .frame(width:150, height:50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                        
                    }
                        
                    Button("Crear cuenta") {
                        //Verificar contraseña es igual, guardar en base de datos usuario, contraseña, direccion y coordenadas de la direccion y mostrar ventana confirmación cuenta
                        correctRegister = true
                    }
                    .padding()
                    .foregroundColor(Color.white )
                    .frame(width:300, height:50)
                    .background(Color(hue: 0.374, saturation: 0.846, brightness: 0.426))
                    .cornerRadius(10)
                    .padding()
                
                }
            }
            .navigationDestination(isPresented: $correctRegister) {
                          MainMenuView()
            }
            
        }
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
