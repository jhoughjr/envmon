import SwiftIO
import MadBoard

func co2Thread(_ a: UnsafeMutableRawPointer?, _ b: UnsafeMutableRawPointer?, _ c: UnsafeMutableRawPointer?) -> () {

// 19 yello RX
// 20 GREEN TX
let co2_uart = UART(Id.UART2, baudRate: 9600)
let readCMD: [UInt8] = [0xFF, 0x01, 0x86, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79]
// shuold add commands for span and zero...
let co2_interval: Int = 5000

var message = [UInt8](repeating: 0, count: 9)

while true {
    print(" co2_thread - sleeping for \(co2_interval) ms.")
    sleep(ms: co2_interval)
    print(" co2_thread - awake!")
    let count = co2_uart.checkBufferReceived()
   
    if count > 0 {
        // Read data from the buffer.
        let _ = co2_uart.read(into:&message, count: count)
        
        co2Mutex.lock()
        ppm = (Int16(message[2]) * 256) + Int16(message[3])
        co2Mutex.unlock()
        for i: Int in 0..<message.count {
            message[i] = 0
        }
    }

    print(" co2_thread - sending read command...")
    co2_uart.write(readCMD)

}
}