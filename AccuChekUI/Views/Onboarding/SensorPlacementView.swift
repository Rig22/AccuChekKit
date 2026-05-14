import SwiftUI

struct SensorPlacementView: View {
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        Image(imageName: "placement_0")
                            .resizable()
                            .scaledToFit()
                        Image(imageName: "placement_1")
                            .resizable()
                            .scaledToFit()
                    }
                    .background(.white)

                    Text(
                        "Select your right or left arm to apply the sensor. Make sure to disinfect the chosen area first.",
                        comment: "step1 body"
                    )
                }
            } header: {
                Text("Step 1", comment: "label step1")
            }

            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image(imageName: "placement_2")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Spacer()
                    }
                    .background(.white)

                    Text(
                        "Slightly flip the pull tab open. If the pull tab has already been opened before use, discard the device and use a new one.",
                        comment: "step2 body"
                    )
                }
            } header: {
                Text("Step 2", comment: "label step2")
            }

            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image(imageName: "placement_3")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Spacer()
                    }
                    .background(.white)

                    Text(
                        "Turn the twist cap to open the sterile barrier. You will feel a slight resistance and hear a cracking sound. Pull the twist cap from the applicator.",
                        comment: "step3 body"
                    )
                }
            } header: {
                Text("Step 3", comment: "label step3")
            }

            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image(imageName: "placement_4")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Spacer()
                    }
                    .background(.white)

                    Text(
                        "Place the hand of the disinfected arm on your opposite shoulder. Reach under your arm and place the applicator on the site. Press down firmly to insert the sensor.",
                        comment: "step4 body"
                    )
                }
            } header: {
                Text("Step 4", comment: "label step4")
            }

            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image(imageName: "placement_5")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Spacer()
                    }
                    .background(.white)

                    Text(
                        "Remove the applicator in the same direction without rotating or wiggling it. Swipe over the adhesive pad firmly with your finger to make sure the adhesive pad is properly attached.",
                        comment: "step5 body"
                    )
                }
            } header: {
                Text("Step 5", comment: "label step5")
            }

            Section {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Spacer()
                        Image(imageName: "twistcap")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 150)
                        Spacer()
                    }
                    .background(.white)

                    Text(
                        "Do not discard the twistcap until the pairing is completed! You will need the Sensor's Serial Number and PIN information during the pairing",
                        comment: "step6 body"
                    )
                }
            } header: {
                Text("Important", comment: "label important")
            }
        }
        .navigationTitle(String(localized: "Placement Guide", comment: "label placement guide"))
    }
}
