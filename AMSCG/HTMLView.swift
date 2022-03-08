//
//  CustomWKWebView.swift
//  AMSCG
//
//  Created by Slobodan Djukanovic on 24.1.22..
//

// https://developer.apple.com/forums/thread/126986
// https://developer.apple.com/forums/thread/117073

import SwiftUI
import WebKit

struct HTMLView: UIViewRepresentable {
    let htmlString: String?
    
    func makeCoordinator() -> HTMLView.Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Self.Context) -> WKWebView {
        let view = WKWebView()
        view.isOpaque = false
        view.scrollView.showsVerticalScrollIndicator = false
        view.navigationDelegate = context.coordinator
        view.uiDelegate = context.coordinator
        view.loadHTMLString(htmlString ?? "", baseURL: Bundle.main.bundleURL)
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlString ?? "", baseURL: Bundle.main.bundleURL)
    }
    
    class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate {
        let parent: HTMLView

        init(_ parent: HTMLView) {
            self.parent = parent
        }
        
        // This function is required to enable opening hyperlinks in webview
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                if navigationAction.navigationType == .linkActivated  {
                    if let url = navigationAction.request.url,
                        UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url)
                        decisionHandler(.cancel)
                    } else {
                        decisionHandler(.allow)
                    }
                } else {
                    decisionHandler(.allow)
                }
        }
    }
}

struct HTMLViewLoad: View {
    let urlString: String
    var title: LocalizedStringKey
    @State var text: String = ""
    @State private var isLoading = true

    var body: some View {
        ZStack {
            HTMLView(htmlString: text)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 10))
            
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.blueAMSCG))
                    .scaleEffect(1.5, anchor: .center)
            }
        }
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.white)
        .onAppear {
            Task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: urlString) else {
            text = "Invalid URL"
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(JSONInfo.self, from: data) {
                isLoading = false
                if decodedResponse.action == true {
                    text = decodedResponse.info.text
                } else {
                    text = "<h1>No information to show. We are sorry.</h1>"
                }
                text = prepareHTML(text)
            }
        } catch {
            text = "Invalid data"
        }
    }
    
    func prepareHTML(_ text: String) -> String {
        let meta = """
        <!doctype html><head><meta charset='utf-8'/><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'><link href='https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,400;0,700;1,400;1,700&display=swap' rel='stylesheet'> <style>body {font-family: 'Lato', sans-serif; color: #00214D}</style></head><body>
        """
        let toRemove = ["<p><br></p>", "<p>&nbsp;</p>", "<h1><br></h1>", "<h2><br></h2>",
                        "<h3><br></h3>", "<h4><br></h4>", "<p><strong>&nbsp;</strong></p>"]
        var formattedText: String = text
        for tr in toRemove {
            formattedText = formattedText.replacingOccurrences(of: tr, with: "")
        }
        formattedText = "\(meta)\(formattedText)</body></html>"
        
        return formattedText
    }
}
