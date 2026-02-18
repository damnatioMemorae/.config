import Quickshell

SystemClock {
        id: Clock
        precision: SystemClock.Seconds
}

Text {
        text: Qt.formateDateTime(clock.date, "hh:mm:ss - yyyy-MM-dd")
}
