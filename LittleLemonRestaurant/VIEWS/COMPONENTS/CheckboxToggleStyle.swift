//
//  CheckboxToggleStyle.swift
//  LittleLemonRestaurant
//
//  Created by Herrera-Camara, Jorge on 05/03/23.
//

import SwiftUI

extension ToggleStyle where Self == CheckBoxToggleStyle {
    static var checkbox: CheckBoxToggleStyle {
        return CheckBoxToggleStyle()
    }
}

struct CheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
                    .font(.system(size: 14.0))
                    .foregroundColor(greenColor)
            } icon: {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .foregroundColor(configuration.isOn ? greenColor : .secondary)
                    .accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
                    .imageScale(.large)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

