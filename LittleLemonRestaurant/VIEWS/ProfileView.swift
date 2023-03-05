//
//  ProfileView.swift
//  LittleLemonRestaurant
//
//  Created by Jorge Ivan Herrera Camara on 05/03/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentation
    @State var isActive: Bool = false
    @State var firstName: String = ""
    @State var lastName: String = ""
    @State var email: String = ""
    @State var phoneNumber: String = ""
    @State var isOrderStatuses = false
    @State var isPasswordChanges = false
    @State var isSpecialOffer = false
    @State var isNewsletter = false
    
    init() {
        let firstName = UserDefaults.standard.string(forKey: lemonFirstName) ?? ""
        let lastName = UserDefaults.standard.string(forKey: lemonLastName) ?? ""
        let email = UserDefaults.standard.string(forKey: lemonEmail) ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: lemonPhoneNumber) ?? ""
        let orderStatusEnabled = UserDefaults.standard.bool(forKey: lemonOrderStatusEnabled)
        let passwordChangesEnabled = UserDefaults.standard.bool(forKey: lemonPasswordChangesEnabled)
        let specialOfferEnabled = UserDefaults.standard.bool(forKey: lemonSpecialOfferEnabled)
        let newsletterEnabled = UserDefaults.standard.bool(forKey: lemonNewsLetterEnabled)
        self._firstName = State(initialValue: firstName)
        self._lastName = State(initialValue: lastName)
        self._email = State(initialValue: email)
        self._phoneNumber = State(initialValue: phoneNumber)
        self._isOrderStatuses = State(initialValue: orderStatusEnabled)
        self._isPasswordChanges = State(initialValue: passwordChangesEnabled)
        self._isSpecialOffer = State(initialValue: specialOfferEnabled)
        self._isNewsletter = State(initialValue: newsletterEnabled)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                profilePictureInfo
                lemonProfileForm
                lemonCheckboxes
        
                VStack(alignment: .center) {
                    NavigationLink(destination: SplashView().navigationBarBackButtonHidden(true),isActive: $isActive) {EmptyView()}
                    logoutButton
                }
                
                HStack() {
                    Spacer()
                    discardChangesButton
                    Spacer()
                    saveChangesButton
                    Spacer()
                }
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 0.0) {
                        Image("lemon")
                            .resizable()
                            .scaledToFit()
                            .frame(width:34.0, height:34.0)
                            .padding(.bottom, 4.0)
                        Text("LITTLE LEMON")
                            .font(.system(size: 12.0))
                            .fontWeight(.semibold)
                            .foregroundColor(greenColor)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                            Image("profilePicture")
                                .resizable()
                                .scaledToFit()
                                .frame(width:36.0, height:36.0)
                                .cornerRadius(18.0)
                                .padding(.bottom, 8.0)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func reloadUserDefaults() {
        let firstName = UserDefaults.standard.string(forKey: lemonFirstName) ?? ""
        let lastName = UserDefaults.standard.string(forKey: lemonLastName) ?? ""
        let email = UserDefaults.standard.string(forKey: lemonEmail) ?? ""
        let phoneNumber = UserDefaults.standard.string(forKey: lemonPhoneNumber) ?? ""
        let orderStatusEnabled = UserDefaults.standard.bool(forKey: lemonOrderStatusEnabled)
        let passwordChangesEnabled = UserDefaults.standard.bool(forKey: lemonPasswordChangesEnabled)
        let specialOfferEnabled = UserDefaults.standard.bool(forKey: lemonSpecialOfferEnabled)
        let newsletterEnabled = UserDefaults.standard.bool(forKey: lemonNewsLetterEnabled)
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.isOrderStatuses = orderStatusEnabled
        self.isPasswordChanges = passwordChangesEnabled
        self.isSpecialOffer = specialOfferEnabled
        self.isNewsletter = newsletterEnabled
    }
    
    private var profilePictureInfo: some View {
        VStack(alignment: .leading) {
            Text("Personal Information")
                .font(.system(size: 15.0))
                .fontWeight(.semibold)
            Text("Avatar")
                .font(.system(size: 12.0))
                .foregroundColor(.gray)
            HStack(spacing: 16.0) {
                Image("profilePicture")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80.0, height: 80.0)
                    .cornerRadius(40.0)
                Button(action: {
                    print("Background Color")
                }, label: {
                    Text("Change")
                        .font(.system(size: 14.0))
                        .fontWeight(.semibold)
                        .padding(8.0)
                        .background(greenColor)
                        .foregroundColor(.white)
                        .cornerRadius(6.0)
                })
                Button(action: {
                    print("Background Color")
                }, label: {
                    Text("Remove")
                        .font(.system(size: 14.0))
                        .fontWeight(.semibold)
                        .padding(8.0)
                        .background(
                            RoundedRectangle(cornerRadius: 6.0)
                                .stroke(lineWidth: 2)
                        )
                        .foregroundColor(greenColor)
                        .cornerRadius(6.0)
                })
            }
            .padding(.bottom, 16.0)
        }
    }
    
    private var lemonProfileForm: some View {
        Group {
            Text("First name")
                .font(.system(size: 12.0))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            TextField("First name", text: $firstName)
                .font(.system(size: 14.0))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 16.0)
            Text("Last name")
                .font(.system(size: 12.0))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            TextField("Last name", text: $lastName)
                .font(.system(size: 14.0))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 16.0)
            Text("Email")
                .font(.system(size: 12.0))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            TextField("Email", text: $email)
                .font(.system(size: 14.0))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 16.0)
            Text("Phone number")
                .font(.system(size: 12.0))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            TextField("Phone number", text: $phoneNumber)
                .font(.system(size: 14.0))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 16.0)
        }
    }
    
    private var lemonCheckboxes: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Email Notification")
                .font(.system(size: 15.0))
                .fontWeight(.semibold)
            
            Toggle("Order Statuses", isOn: $isOrderStatuses)
                .toggleStyle(CheckBoxToggleStyle.checkbox)
            Toggle("Password changes", isOn: $isPasswordChanges)
                .toggleStyle(CheckBoxToggleStyle.checkbox)
            Toggle("Special offers", isOn: $isSpecialOffer)
                .toggleStyle(CheckBoxToggleStyle.checkbox)
            Toggle("Newsletter", isOn: $isNewsletter)
                .toggleStyle(CheckBoxToggleStyle.checkbox)
            
        }
    }
    
    // logout button
    private var logoutButton: some View {
        Button(action: {
            UserDefaults.standard.set("", forKey: lemonFirstName)
            UserDefaults.standard.set("", forKey: lemonLastName)
            UserDefaults.standard.set("", forKey: lemonLoggedIn)
            UserDefaults.standard.set("", forKey: lemonPhoneNumber)
            UserDefaults.standard.set(false, forKey: lemonOrderStatusEnabled)
            UserDefaults.standard.set(false, forKey: lemonPasswordChangesEnabled)
            UserDefaults.standard.set(false, forKey: lemonSpecialOfferEnabled)
            UserDefaults.standard.set(false, forKey: lemonNewsLetterEnabled)
            isActive.toggle()
        }, label: {
            Text("Log out")
                .font(.system(size: 14.0))
                .fontWeight(.semibold)
                .padding([.top, .bottom], 8.0)
                .frame(maxWidth:.infinity)
                .background(
                    RoundedRectangle(cornerRadius: 6.0)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.orange)
                        .background(lemonColor)
                )
                .foregroundColor(.black)
                .cornerRadius(6.0)
        })
        .padding([.top, .bottom], 16.0)
    }
    
    private var saveChangesButton: some View {
        Button(action: {
            UserDefaults.standard.set(firstName, forKey: lemonFirstName)
            UserDefaults.standard.set(lastName, forKey: lemonLastName)
            UserDefaults.standard.set(email, forKey: lemonEmail)
            UserDefaults.standard.set(phoneNumber, forKey: lemonPhoneNumber)
            UserDefaults.standard.set(isOrderStatuses, forKey: lemonOrderStatusEnabled)
            UserDefaults.standard.set(isPasswordChanges, forKey: lemonPasswordChangesEnabled)
            UserDefaults.standard.set(isSpecialOffer, forKey: lemonSpecialOfferEnabled)
            UserDefaults.standard.set(isNewsletter, forKey: lemonNewsLetterEnabled)
            self.presentation.wrappedValue.dismiss()
        }, label: {
            Text("Save changes")
                .font(.system(size: 16.0))
                .padding(8.0)
                .background(greenColor)
                .foregroundColor(.white)
                .cornerRadius(6.0)
        })
    }
    
    private var discardChangesButton: some View {
        Button(action: {
            reloadUserDefaults()
        }, label: {
            Text("Discard changes")
                .font(.system(size: 16.0))
                .padding(8.0)
                .background(
                    RoundedRectangle(cornerRadius: 6.0)
                        .stroke(lineWidth: 2)
                )
                .foregroundColor(greenColor)
                .cornerRadius(6.0)
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
