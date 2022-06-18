//
//  MobilityDescView.swift
//  Alze
//
//  Created by Kevin  Sam Andaria on 16/06/22.
//

import SwiftUI

struct MobilityDescView: View {
    @State var onTap:Bool = true
    @State var solvedBy:String = ""
    @State var notes:String = ""
    @State var desc:String = "Walking exercise regularly can improve physical fitness and reduce the risk of various life-threatening diseases. Walking exercise regularly can improve physical fitness and reduce the risk of various life-threatening diseases. Walking exercise regularly can improve physical fitness and reduce the risk of various life-threatening diseases. Walking exercise regularly can improve physical fitness and reduce the risk of various life-threatening diseases. "
    
    var body: some View {
        ScrollView(.vertical){
            HStack{
                VStack(spacing: 24){
                    //Title
                    Group{
                        VStack(alignment:.leading, spacing: 8){
                            Text("Walk For 15 Minutes")
                                .font(.title)
                                .fontWeight(.medium)
                                .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 30, idealHeight: 30, maxHeight: 30, alignment: .leading)
                            
                            Text("Mobility")
                                .font(.system(size: 16))
                                .frame(width: 75, height: 30)
                                .foregroundColor(.white)
                                .background(K.CustomColor.color5.cornerRadius(8))
                        }
                    }
                    
                    //Description
                    Group{
    //                    GeometryReader { proxy in
                            VStack(){
                                Text("Description")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 25, idealHeight: 25, maxHeight: 25, alignment: .leading)

                                Text(desc)
                                    .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    
                    //Solved By
                    Group{
                        VStack(spacing: 8){
                            Text("Solved By")
                                .font(.title3)
                                .fontWeight(.medium)
                                .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            
                            HStack(spacing: 18){
                                Button("Independent") {
                                    self.solvedBy = "Independent"
                                    self.onTap = true
                                }
                                .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                                .foregroundColor(.black)
                                .background(onTap ? K.CustomColor.color2.cornerRadius(25) : Color.clear.cornerRadius(25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(K.CustomColor.color1)
                                )
                                
                                
                                Button("With Assistance") {
                                    self.solvedBy = "With Assistance"
                                    self.onTap = false
                                }
                                .frame(minWidth: 167, idealWidth: 167, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                                .foregroundColor(.black)
                                .background(onTap ? Color.clear.cornerRadius(25) : K.CustomColor.color2.cornerRadius(25))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(K.CustomColor.color1)
                                )
                            }
                        }
                    }
                    
                    //Notes
                    Group{
                        VStack(spacing: 8){
                            Text("Notes")
                                .font(.system(size: 16))
                                .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 20, idealHeight: 20, maxHeight: 20, alignment: .leading)
                            
                            TextField("Write a note about the activity you've done...", text: $notes )
                                .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 140, idealHeight: 140, maxHeight: 140, alignment: .topLeading)
                                .padding(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(K.CustomColor.color1)
                                )
                        }
                    }
                    
                    Spacer()
                    
                    Group{
                        Button {
                            onTap = false
                        } label: {
                            Text("Done")
                        }
                        .frame(minWidth: 350, idealWidth: 350, maxWidth: .infinity, minHeight: 51, idealHeight: 51, maxHeight: 51)
                        .foregroundColor(.white)
                        .background(K.CustomColor.color1.cornerRadius(25))
                    }
                }
            }.padding(16)
        }
    }
}

struct MobilityDescView_Previews: PreviewProvider {
    static var previews: some View {
        MobilityDescView()
    }
}
