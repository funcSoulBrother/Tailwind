//
//  GoogleBannerView.swift
//  Helping Hand
//
//  Created by Daniel Marsh on 9/7/25.
//
import SwiftUI
import GoogleMobileAds
import UIKit

struct AdBannerView: UIViewRepresentable {
    let adUnitID: String
    
    func makeUIView(context: Context) -> BannerView {
        let bannerView = BannerView(adSize: AdSize(size: CGSize(width: 320, height: 50), flags: 0))
        bannerView.adUnitID = adUnitID
        bannerView.rootViewController = getRootViewController()
        bannerView.delegate = context.coordinator
        
        let request = Request()
        print("🔄 Loading ad with unit ID: \(adUnitID)")
        bannerView.load(request)
        return bannerView
    }
    
    func updateUIView(_ uiView: BannerView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, BannerViewDelegate {
        func bannerViewDidReceiveAd(_ bannerView: BannerView) {
            print("✅ Ad loaded successfully")
        }
        
        func bannerView(_ bannerView: BannerView, didFailToReceiveAdWithError error: Error) {
            print("❌ Ad failed to load: \(error)")
            print("❌ Error description: \(error.localizedDescription)")
        }
    }
    
    private func getRootViewController() -> UIViewController? {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return nil
        }
        return window.rootViewController
    }
}
