//
//  ChatView.swift
//  HostelManager
//
//  Created by Shashwat Singh on 9/11/24.
//

import SwiftUI

struct ChatView: View {
    @State private var textInput = ""
    @State private var logoAnimating = false
    @State private var timer: Timer?
    @ObservedObject private var chatService = ChatService()  // Observe ChatService

    var body: some View {
        VStack {
            // MARK: Animating Logo
            Image(systemName: "message.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.yellow)
                .frame(width: 80)
                .opacity(logoAnimating ? 0.5 : 1)
                .animation(.easeInOut, value: logoAnimating)

            // MARK: Chat Message List
            ScrollViewReader { proxy in
                ScrollView {
                    ForEach(chatService.messages) { chatMessage in
                        chatMessageView(chatMessage)
                    }
                }
                .onChange(of: chatService.messages) { _ in
                    // Scroll to the latest message when new message is added
                    guard let recentMessage = chatService.messages.last else { return }
                    withAnimation {
                        proxy.scrollTo(recentMessage.id, anchor: .bottom)
                    }
                }
                .onChange(of: chatService.loadingResponse) { newValue in
                    // Start or stop loading animation based on response loading status
                    if newValue {
                        startLoadingAnimation()
                    } else {
                        stopLoadingAnimation()
                    }
                }
            }

            // MARK: Input Field and Send Button
            HStack {
                TextField("Enter a message...", text: $textInput)
                    .textFieldStyle(.roundedBorder)
                    .background(Color.black.opacity(0.05))
                    .foregroundColor(.black)
                    .bold()

                Button(action: sendMessage) {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.yellow)
                }
            }
            .padding()
        }
        .padding()
        .background(Color.white.ignoresSafeArea())
    }

    // MARK: Chat Message View
    @ViewBuilder
    private func chatMessageView(_ message: ChatMessage) -> some View {
        ChatBubble(direction: message.role == .model ? .left : .right) {
            Text(message.message)
                .font(.title3)
                .padding(20)
                .foregroundStyle(.white)
                .background(message.role == .model ? Color.gray : Color.yellow)
        }
    }

    // MARK: Send Message
    private func sendMessage() {
        chatService.sendMessage(textInput)
        textInput = ""
    }

    // MARK: Loading Animation Control
    private func startLoadingAnimation() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            logoAnimating.toggle()
        }
    }

    private func stopLoadingAnimation() {
        logoAnimating = false
        timer?.invalidate()
        timer = nil
    }
}


struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
