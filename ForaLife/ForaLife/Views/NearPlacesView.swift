//
//  NearPlacesView.swift
//  ForaLife
//
//  Created by Fernando Ahuatzin Gallardo on 16/06/23.
//

import SwiftUI

struct NearPlacesView: View {
    @State var place: String
    @State var typeOfPlace: String
    @State var fromAddress: Bool
    @State var addressLocation: AddressLocation
    @State var departingPlace: String = "hogar"
    @State var latitude = 0.0
    @State var longitude = 0.0
    @State var alreadyEntered = false
    @State var placesArray: [Place] = []
    @State var arrive = [true,false,false]
    @ObservedObject var currrentLocation = CurrentLocationManager()
    let nearPlacesManager = NearPlacesManager()
    let searchLocationManager = SearchLocationManager()
    
    
    var body: some View {
        
        NavigationStack{
            VStack {
                Text(place)
                    .font(.title)
                    .bold()
                    .foregroundColor(Color(hue: 0.374, saturation: 0.846, brightness: 0.426))
                    .multilineTextAlignment(.center)
                    .onAppear() {
                        if !fromAddress {
                            departingPlace = "ubicación"
                        }
                    }
                Text("Cerca de tú " + departingPlace)
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .onAppear {
                        // Llama al método de búsqueda al aparecer la vista
                        if !alreadyEntered{
                            latitude = searchLocationManager.getSearchLocationLatitude(fromAddress: fromAddress, currentLocation: currrentLocation, addressLocation: addressLocation)
                            longitude = searchLocationManager.getSearchLocationLongitude(fromAddress: fromAddress, currentLocation: currrentLocation, addressLocation: addressLocation)
                            nearPlacesManager.searchNearbyPlaces(sourceLatitude:latitude,sourceLongitude: longitude,typeOfPlace: typeOfPlace, apiKey: "AIzaSyBYAmE0kwIjb3eyVI0dZCcR-vW75tuX1js") { places in
                                placesArray = places
                            }
                            alreadyEntered  = true
                        }
                    }
                Spacer()
                List (placesArray, id: \.id){place in
                    NearPlaceRow(place: place, sourceLatitude: latitude, sourceLongitude: longitude)
                }
                
                Text("¿Cómo planeas llegar?")
                    .padding()
                    .font(.title)
                HStack {
                    Toggle(isOn: $arrive[0]) {
                        HStack {
                            Image(systemName: "figure.walk.circle")
                                .resizable()
                                .frame(width: 30, height:30)
                                .padding()
                          
                        }
                    }
                    .padding()
                    .onChange(of: arrive[0]) { newValue in
                        if arrive[0] {
                            arrive[1] = !arrive[0]
                            arrive[2] = !arrive[0]
                        }
                        if  !arrive[1] && !arrive[2] {
                            arrive[0] = true
                        }
                        
                    }
                    
                    Toggle(isOn: $arrive[1]) {
                        HStack {
                            Image(systemName: "car.circle")
                                .resizable()
                                .frame(width: 30, height:30)
                                .padding()
                         
                        }
                    }
                    .onChange(of: arrive[1]) { newValue in
                        if arrive[1] {
                            arrive[0] = !arrive[1]
                            arrive[2] = !arrive[1]
                        }
                        if !arrive[0] && !arrive[2] {
                            arrive[1] = true
                        }
                       
                    }
                    
                    Toggle(isOn: $arrive[2]) {
                        HStack {
                            Image(systemName: "tram.circle")
                                .resizable()
                                .frame(width: 30, height:30)
                                .padding()
                           
                        }
                    }
                    .padding()
                    .onChange(of: arrive[2]) { newValue in
                        if arrive[2] {
                            arrive[0] = !arrive[2]
                            arrive[1] = !arrive[2]
                        }
                        if !arrive[0] && !arrive[1] {
                            arrive[2] = true
                        }
                        
                    }
                    Spacer()
                

                }
                Spacer()
                
                Footer()
            }
        }
        
        
        
    }
}

struct NearPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        NearPlacesView(place: "Restaurantes",typeOfPlace: "Restaurant", fromAddress: true, addressLocation: AddressLocation(latitude: 0.0, longitude: 0.0))
    }
}
