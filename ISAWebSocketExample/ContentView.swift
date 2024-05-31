//
//  ContentView.swift
//  ISAWebSocketExample
//
//  Created by Isaías Santana on 24/04/24.
//

import SwiftUI
import ISAWebSocket
import Network

final class SocketHandler: ISAWebSocketDelegate {

    let socket = ISAWebSocket(url: URL(string: "wss://api-invest.uatbi.com.br/api/inv-hb-book-ofertas-broadcaster/v1/ws/orders/cogn3")!)

    init() {
        socket.delegate = self
    }

    func socket(_ socket: WebSocketClient, didReceiveConnectionStatus status: ConnectionStatus) {
        print("connection status ", status)
    }

    func socket(_ socket: WebSocketClient, didReceiveMessage message: Result<SocketMessage, NWError>) {
        print("message response ", message)
    }

    func socket(_ socket: WebSocketClient, sendMessageDidFailedWithError error: NWError) {
        print("failed sent message ", error)
    }

    func socket(_ socket: WebSocketClient, didReceivePingPongStatus status: PingPongStatus) {
        print("ping/pong status ", status)
    }

}

struct ContentView: View {
    @State private var handler = SocketHandler()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Button("Send Message", action: {
                handler.socket.send(message: .data(Data([1,3])))
            })

            Button("Close connection", action: {
                handler.socket.closeConnection()
            })

            Button("Send Ping", action: {
                handler.socket.sendPing()
            })
        }
        .padding()
        .onAppear(perform: {
            handler.socket.startConnection()
        })
    }
}

#Preview {
    ContentView()
}
