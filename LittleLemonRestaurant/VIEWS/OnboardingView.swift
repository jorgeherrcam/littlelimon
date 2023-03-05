//
//  OnboardingView.swift
//  LittleLemonRestaurant
//
//  Created by Jorge Ivan Herrera Camara on 05/03/23.
//

import SwiftUI
import CoreData

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentation
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var isActive: Bool = false
    
    var body: some View {
    NavigationView {
        VStack(alignment: .leading) {
            heroView
            onboardingForm
            VStack(alignment: .center) {
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true),
                               isActive: $isActive) {
                    EmptyView()
                }
                registerButton
            }
            .padding()
            .background(greenColor)
        }.frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        ).background(greenColor)
    }
        
}
    private var registerButton: some View {
        Button(action: {
            UserDefaults.standard.set(firstName, forKey: lemonFirstName)
            UserDefaults.standard.set(lastName, forKey: lemonLastName)
            UserDefaults.standard.set(email, forKey: lemonEmail)
            UserDefaults.standard.setValue(true, forKey: lemonLoggedIn)
            isActive.toggle()
        }) {
            Text("Register")
                .fontWeight(.bold)
                .frame(width: 250, height: 44)
                .background(.yellow)
                .foregroundColor(.white)
                .cornerRadius(22)
        }
        .frame(minWidth: 100, maxWidth: .infinity, minHeight: 44)
        .disabled(firstName.isEmpty || lastName.isEmpty || email.isEmpty)
    }
    
    private var heroView: some View {
        VStack(alignment:.leading) {
            Text("Little Lemon")
                .font(.system(size: 44.0))
                .bold()
                .foregroundColor(Color(red: 242/255, green: 197/255, blue: 50/255))
            Text("Chicago")
                .font(.system(size: 26.0))
                .fontWeight(.semibold)
                .foregroundColor(.white)
            HStack {
                Text("We are a family owned\nMediterranean restaurant,\nfocused on traditional\nrecipes served with a\nmodern twist.")
                    .font(.system(size: 16.0))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
                Image("heroMainDish")
                    .resizable()
                    .scaledToFit()
                    .frame(width:150.0, height:150.0)
                    .cornerRadius(10.0)
            }.background(greenColor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 0, trailing: 6))
                .foregroundColor(.secondary)
                .background(greenColor)
                .cornerRadius(6.0)
        }
        .padding()
        .background(greenColor)
    }
    
    private var onboardingForm: some View {
        VStack(alignment: .leading) {
            Text("First Name *")
            TextField("First Name", text: $firstName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Last name *")
             TextField("Last name", text: $lastName)
             .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Email *")
            TextField("tillydoe@example.com", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
        }.padding()
            .background(whiteColor)
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView().environmentObject(Model())
    }
}




