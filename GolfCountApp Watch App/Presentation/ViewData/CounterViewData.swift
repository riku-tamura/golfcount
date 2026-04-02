//
//  CounterViewData.swift
//  GolfCountApp Watch App
//

import Foundation

struct CounterViewData: Identifiable {
    let metric: GolfCountMetric
    let title: String
    let subtitle: String?
    let valueText: String
    let valueAccessibilityLabel: String
    let decrementButtonText: String
    let incrementButtonText: String
    let decrementAccessibilityLabel: String
    let incrementAccessibilityLabel: String
    let isDecrementDisabled: Bool
    let isIncrementDisabled: Bool

    var id: GolfCountMetric { metric }

    init(metric: GolfCountMetric, record: GolfCountRecord) {
        let value = metric.value(in: record)

        self.metric = metric
        title = metric.title
        subtitle = metric.subtitle
        valueText = "\(value)"
        valueAccessibilityLabel = "\(record.selectedHoleLabel) の\(metric.title) \(value)"
        decrementButtonText = "-1"
        incrementButtonText = "+1"
        decrementAccessibilityLabel = "\(record.selectedHoleLabel) の\(metric.title)を1減らす"
        incrementAccessibilityLabel = "\(record.selectedHoleLabel) の\(metric.title)を1増やす"
        isDecrementDisabled = value <= metric.minimumValue
        isIncrementDisabled = metric.maximumValue(in: record).map { value >= $0 } ?? false
    }
}
