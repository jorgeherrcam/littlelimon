import SwiftUI

let lemonFirstName = "lemonFirstName"
let lemonLastName = "lemonLastName"
let lemonEmail = "lemonEmail"
let lemonPhoneNumber = "lemonPhoneNumber"
let lemonOrderStatusEnabled = "lemonOrderStatusEnabled"
let lemonPasswordChangesEnabled = "lemonPasswordChangesEnabled"
let lemonSpecialOfferEnabled = "lemonSpecialOfferEnabled"
let lemonNewsLetterEnabled = "lemonNewsLetterEnabled"
let lemonLoggedIn = "lemonLoggedIn"

@main
struct LittleLemonRestaurantApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            SplashView().environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
