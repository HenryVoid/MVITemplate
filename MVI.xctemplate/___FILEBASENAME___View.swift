//___FILEHEADER___

import Foundation
import SwiftUI

// MARK: ___FILEBASENAMEASIDENTIFIER___

struct ___FILEBASENAMEASIDENTIFIER___: IntentBindingType {
    @StateObject var container: Container<___VARIABLE_productName:identifier___IntentType, ___VARIABLE_productName:identifier___Model.State>
    var intent: ___VARIABLE_productName:identifier___IntentType { self.container.intent }
    var state: ___VARIABLE_productName:identifier___Model.State { self.intent.state }
}

// MARK: Body

extension ___FILEBASENAMEASIDENTIFIER___: ViewControllable {
    
    var body: some View {
        VStack {
            
        }
    }
}

// MARK: Build

extension ___FILEBASENAMEASIDENTIFIER___ {
    static func build(intent: ___VARIABLE_productName:identifier___Intent) -> UIViewController {
        return ___FILEBASENAMEASIDENTIFIER___(
            container: .init(
                intent: intent as ___VARIABLE_productName:identifier___IntentType,
                state: intent.state,
                modelChangePublisher: intent.objectWillChange
            )
        )
        .viewController
    }
}
