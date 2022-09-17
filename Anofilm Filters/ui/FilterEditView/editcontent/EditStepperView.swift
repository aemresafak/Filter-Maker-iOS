//
//  EditStepperView.swift
//  Anofilm Filters
//
//  Created by ahmetknk on 17.09.2022.
//

import SwiftUI

struct EditStepperView<Value:Strideable & LosslessStringConvertible> : View {
    var title: String
    @Binding var value: Value
    var range: ClosedRange<Value>
    var resetValue: Value
    
    var body: some View {
        HStack {
            Stepper(value: $value, in: range) {
                Text("\(title): \(value.description)")
            }
            Button {
                value = resetValue
            } label: {
                Image(systemName: "arrow.uturn.backward")
            }
        }
    }
}
