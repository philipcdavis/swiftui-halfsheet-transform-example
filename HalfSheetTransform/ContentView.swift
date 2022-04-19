//
//  ContentView.swift
//  HalfSheetTransform
//
//  Created by Philip Davis on 4/18/22.
//
import SwiftUI

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(.green)
            .foregroundColor(.white)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .scaleEffect(configuration.isPressed ? 0.97: 1)
    }
}

struct IconButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(.gray.opacity(0.1))
            .foregroundColor(.black)
            .font(.system(size: 16, weight: .bold, design: .rounded))
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.97: 1)
    }
}

struct ContentView: View {
    @State private var isHalfSheet = true
    @State private var slowMotion = false
    @State private var angle = Angle(degrees: 0)
    var body: some View {
        ZStack {
            Color(.black).ignoresSafeArea()
            ZStack {
                Button {
                    withAnimation(slowMotion ? .interactiveSpring(response: 4, dampingFraction: 0.86, blendDuration: 4) : .spring()) {
                        isHalfSheet.toggle()
                    }
                } label: {
                    Image(systemName: "xmark")
                }.buttonStyle(IconButton())
                    .scaleEffect(isHalfSheet ? 1 : 0.5)
                    .position(x: isHalfSheet ? UIScreen.main.bounds.width - 85 : UIScreen.main.bounds.width - 160, y: isHalfSheet ? 25 : 20)
                    .opacity(isHalfSheet ? 1 : 0)
                    
                    
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.4))
                        .frame(width: 44, height: 6)
                        .offset(y: isHalfSheet ? -182 : -40)
                        
                    
                    
                    Text("Price")
                        .scaleEffect(1)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .opacity(0.7)
                        .offset(y: isHalfSheet ? -152 : -40)
                        .scaleEffect(isHalfSheet ? 1 : 0.8)
                        .opacity(isHalfSheet ? 1 : 0)
                    
                    Text("$7.99")
                        .scaleEffect(isHalfSheet ? 2 : 1)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .offset(y: isHalfSheet ? -110 : 0)
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("Socks")
                            Spacer()
                            Text("$7.99")
                        }.opacity(0.5)
                        
                        HStack {
                            Text("Tax")
                            Spacer()
                            Text("$0.43")
                        }.opacity(0.5)
                        HStack {
                            
                            Text("Total").fontWeight(.bold)
                            Spacer()
                            Text("$8.42").fontWeight(.bold)
                        }
                    }.frame(width: 260)
                    .padding(20)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .background(.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .offset(y: 10)
                    .scaleEffect(isHalfSheet ? 1 : 0.1)
                    .opacity(isHalfSheet ? 1 : 0)
                    Button(slowMotion ? "Slow Motion" : "Regular") {
                            slowMotion.toggle()
                        }
                        .opacity(isHalfSheet ? 1 : 0)
                        .buttonStyle(SecondaryButton())
                        .scaleEffect(isHalfSheet ? 1 : 0.1)
                        .offset(y: isHalfSheet ? 130 : 60)
                }
                
            }
            .padding(.horizontal, 44)
                .padding(.vertical, 16)
                .frame(width: isHalfSheet ? UIScreen.main.bounds.width : 160, height: isHalfSheet ? UIScreen.main.bounds.height / 2 : 50)
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 44, style: isHalfSheet ? .continuous : .circular))
                .rotationEffect(isHalfSheet ? Angle(degrees: angle.degrees > 180 ? 360 : 0) : angle)
                .position(x: UIScreen.main.bounds.width / 2, y: isHalfSheet ? UIScreen.main.bounds.height - UIScreen.main.bounds.height / 4: 120)
                .ignoresSafeArea()
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            
                                angle = value
                                print(angle)
                            
                            
                        }
                )
                
            .onTapGesture {
                withAnimation(slowMotion ? .interactiveSpring(response: 4, dampingFraction: 0.86, blendDuration: 4) : .spring()) {
                    isHalfSheet.toggle()
                }
                
            }
        }.ignoresSafeArea()
            .preferredColorScheme(.light)
            .statusBar(hidden: true)
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
