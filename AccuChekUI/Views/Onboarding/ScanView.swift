import LoopKitUI
import SwiftUI

struct ScanView: View {
    @ObservedObject var viewModel: ScanViewModel

    var body: some View {
        VStack {
            List {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Spacer()
                            Image(imageName: "twistcap")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .frame(height: 150)
                                .padding(.bottom, 20)
                            Spacer()
                        }

                        Text("Keep twist cap", comment: "scanning header")
                            .font(.title3)
                            .bold()

                        Text(
                            "You'll need the twist cap shortly to verify the Sensor's Serial Number (SN) and get your 6-digit PIN",
                            comment: "scanning body"
                        )
                    }
                }
            }
            Spacer()

            VStack(spacing: 5) {
                ActivityIndicator(isAnimating: .constant(true), style: .medium)
                Text("Scanning for CGM", comment: "scanning footer")
                    .font(.footnote)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { viewModel.isShowingPlacement = true }) {
                    Image(systemName: "questionmark.circle")
                }
            }
        }
        .alert(
            String(localized: "Found an Accu Chek CGM!", comment: "found device title"),
            isPresented: $viewModel.showConfirmationAlert,
            presenting: String(
                format: String(localized: "Is this the correct serial number? %@", comment: "found device message"),
                viewModel.foundDeviceLast?.deviceName ?? "EMPTY"
            ),
            actions: { _ in
                Button(action: viewModel.startScanning) {
                    Text("No", comment: "label no")
                }
                Button(action: viewModel.confirm) {
                    Text("Yes", comment: "label yes")
                }
            },
            message: { detail in Text(detail) }
        )
        .alert(
            String(localized: "Found unsupported Accu Chek CGM...", comment: "unsupported device title"),
            isPresented: $viewModel.showUnsupportedDeviceAlert,
            presenting: String(
                format: String(
                    localized:
                    "This Accu-chek Sensor is using advanced encryption which is not supported yet... %@",
                    comment: "unsupported device message"
                ),
                viewModel.unsupportedDevice?.deviceName ?? "EMPTY"
            ),
            actions: { _ in
                Button(action: viewModel.startScanning) {
                    Text("Understood", comment: "label undestood")
                }
            },
            message: { detail in Text(detail) }
        )
        .sheet(isPresented: $viewModel.isShowingPlacement) {
            NavigationView {
                SensorPlacementView()
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: { viewModel.isShowingPlacement = false }) {
                                Text("Close", comment: "label close")
                            }
                        }
                    }
            }
        }
    }
}
