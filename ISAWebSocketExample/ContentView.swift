//
//  ContentView.swift
//  ISAWebSocketExample
//
//  Created by Isaías Santana on 24/04/24.
//

import SwiftUI
import ISAWebSocket

final class SocketHandler: ISAWebSocketDelegate {
    let socket = ISAWebSocket(url: URL(string: "wss://echo.websocket.org/")!)

    init() {
        socket.delegate = self
    }

    func socket(_ socket: WebSocketClient, didReceiveMessage message: SocketMessage) {
        switch message {
        case .string(let string):
            print("Message \(string)")
        case .data(let data):
            print("data receivd \(data)")
        }
    }

    func socket(_ socket: WebSocketClient, didReceiveError error: SocketError) {
        print("error \(error)")
    }

    func socketDidCloseConnection(_ socket: WebSocketClient) {
        print("closed connection")
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
                handler.socket.send(message: .string("Hello message"))
            })

            Button("Close connection", action: {
                handler.socket.closeConnection()
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
