//
//  MapView.swift
//  443App
//
//  Created by Simran Virdi on 10/20/21.
//

//
//  MapView.swift
//  app
//
//  Created by Neha Joshi on 9/28/21.
//
import MapKit
import SwiftUI
import Combine
import Contacts
struct MapView: View {

  // Data for user pins
  @EnvironmentObject var userPins: UserPins
  // Used for tracking current location
  @State var trackingMode: MapUserTrackingMode = .follow
  @State var manager = CLLocationManager()
  @StateObject var managerDelegate = LocationDelegate()
  @ObservedObject var uvm: UserViewModel
  
  //NEHA
  @EnvironmentObject var mapData: MapViewModel
  
  let darkBlue = Color(red: 7/255.0, green: 30/255.0, blue: 75/255.0)
  let lightBlue = Color(red: 220/255.0, green: 249/255.0, blue: 243/255.0)
  
  @State var color="red";
  
  init(uvm: UserViewModel)
  {
    self.uvm = uvm
    //self.mapData=mapData
    
  }
  

  
  var body: some View {

        
    ZStack(alignment: .top){
      //MAP
      Map(coordinateRegion: $mapData.coordinateRegion,
              interactionModes: MapInteractionModes.all,
              showsUserLocation: true,
              userTrackingMode: $trackingMode,
              annotationItems: uvm.memoryPins) { place in
              
            // • If you want larger ballons:
            //MapMarker(coordinate: place.location.coordinates, tint: .blue)
            // • If you want the traditional pin:
            //MapPin(coordinate: place.location.coordinates)
            // • If you want a circle to focus on the location:
             MapAnnotation(coordinate: place.location.coordinates) {

              NavigationLink(destination: PinDetail(uvm: uvm, pin: place)){
                
              HStack {
                VStack(spacing: 0) {
                    let color = place.tags[0].color;
                    Image(systemName: "mappin.circle.fill")
                      .font(.title)
                      .foregroundColor(Color(color))

                    Image(systemName: "arrowtriangle.down.fill")
                      .font(.caption)
                      .foregroundColor(Color(color))
                      .offset(x: 0, y: -5)
                    Text(place.title).font(.caption)
                }
              }
                
              }
             }

          }
          .onAppear {
            manager.delegate = managerDelegate
          }
          .edgesIgnoringSafeArea(.all)
      //MAP
      
      //CREATE BUTTON
      NavigationLink(destination: SetPinLocationView(uvm: uvm).environmentObject(mapData)) {
        Text("Create")
          .padding()
          .foregroundColor(darkBlue)
          .font(Font.headline.weight(.bold))
          .background(lightBlue)
          .overlay(
              RoundedRectangle(cornerRadius: 5)
                  .stroke(darkBlue, lineWidth: 4)
          )
      }
      .offset(y: 645)
      //CREATE BUTTON
      
      //SEARCH BAR
      VStack(spacing:0){
        HStack{
          Image(systemName: "magnifyingglass").foregroundColor(.gray)
          TextField("Search", text: $mapData.searchTxt).colorScheme(.light)
          
        }.padding(.vertical, 10).padding(.horizontal).background(Color.white)
        //DISPLAYING RESULTS
        if !mapData.places.isEmpty && mapData.searchTxt != ""{
          ScrollView{
            VStack(spacing: 15){
              ForEach(mapData.places){place in
                VStack{
                  let res = place.place
                  let resLoc = res.location
                  let city = res.postalAddress?.city
                  let state = res.postalAddress?.state
                Text(res.name ?? "")
                  .foregroundColor(.black)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.leading).onTapGesture{mapData.focusLocation(location: resLoc!)}
                  //.onTapGesture{print(type(of: resLoc))}
                
                Text((city ?? "")+", "+(state ?? "")).font(Font.system(size: 12, design: .default)).foregroundColor(.black).frame(maxWidth: .infinity, alignment: .leading).padding(.leading)
                Divider()
                }
                
              }
            }.padding(.top)
          }.background(Color.white)
        }
      }.padding()
      Spacer()
        .onChange(of: mapData.searchTxt, perform: { value in
          //CHANGE THIS TO ALTER SEARCH SUGGESTION SPEED
          let delay=0.3
          DispatchQueue.main.asyncAfter(deadline: .now()+delay ){
            if value == mapData.searchTxt{
              self.mapData.searchQuery()
            }
          }
        })
      //SEARCH BAR
      
      
      // GO TO USER LOCATION BUTTON
      VStack{
        Spacer()
        VStack{
          Button(action: {
            print($mapData.coordinateRegion.center)
            //mapData.reFocus()
            
          }, label: {
            Image(systemName: "location.fill").font(.title2).padding(10).background(Color.primary).clipShape(Circle())
          })
        }.frame(maxWidth: .infinity, alignment: .trailing).padding()
      }
      // GO TO USER LOCATION BUTTON
        
      
      
    }
         
        

    
  }
  
}

  


