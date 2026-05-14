import LoopKitUI
import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismissAction) private var dismiss
    let manualScan: () -> Void
    let sensorPlacement: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Image(imageName: "sensor")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .frame(height: 150)
                                .padding(.bottom, 10)
                            Spacer()
                        }

                        Text(
                            "Before starting, double check if your Accu-chek CGM is not expired. Expired CGM's cannot be used",
                            comment: "explain welcome"
                        )
                    }
                }
            }

            Spacer()
            VStack(spacing: 10) {
                Button(action: sensorPlacement) {
                    Text("Placement Guide", comment: "label placement guide")
                }
                .buttonStyle(ActionButtonStyle(.secondary))

                Button(action: manualScan) {
                    Text("Continue", comment: "label continue")
                }
                .buttonStyle(ActionButtonStyle())
            }
            .padding(.horizontal)
        }
        .navigationTitle(String(localized: "Welcome!", comment: "welcome"))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: self.dismiss) {
                    Text("Cancel", comment: "Cancel button title")
                }
            }
        }
    }
}
