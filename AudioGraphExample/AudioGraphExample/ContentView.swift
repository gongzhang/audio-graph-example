//
//  ContentView.swift
//  AudioGraphExample
//
//  Created by Gong Zhang on 2022/9/9.
//

import SwiftUI

struct DataPoint: Identifiable {
    let id = UUID()
    let label: String
    let value: Double
}

struct ContentView: View, AXChartDescriptorRepresentable {
    
    @State private var dataPoints = [
        DataPoint(label: "1", value: 3),
        DataPoint(label: "2", value: 5),
        DataPoint(label: "3", value: 2),
        DataPoint(label: "4", value: 4),
    ]
    
    var body: some View {
        VStack {
            Text("Audio Graph")
                .accessibilityLabel(Text("Audio Graph"))
                .accessibilityChartDescriptor(self)
        }
        .padding()
    }
    
    func makeChartDescriptor() -> AXChartDescriptor {
        let xAxis = AXCategoricalDataAxisDescriptor(
            title: "Labels",
            categoryOrder: dataPoints.map(\.label)
        )
        
        let max = dataPoints.map(\.value).max() ?? 0.0
        
        let yAxis = AXNumericDataAxisDescriptor(
            title: "Values",
            range: 0.0...max,
            gridlinePositions: []
        ) { value in "\(value) points" }
        
        let series = AXDataSeriesDescriptor(
            name: "Data",
            isContinuous: false,
            dataPoints: dataPoints.map {
                .init(x: $0.label, y: $0.value)
            }
        )
        
        return AXChartDescriptor(
            title: "Chart representing some data",
            summary: nil,
            xAxis: xAxis,
            yAxis: yAxis,
            additionalAxes: [],
            series: [series]
        )
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
