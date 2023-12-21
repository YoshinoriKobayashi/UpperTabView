//
//  ContentView.swift
//  UpperTabView
//
//  Created by Yoshinori Kobayashi on 2023/12/18.
//

import SwiftUI

enum TabState: String , CaseIterable{
    case post = "投稿"
    case save = "保存"
    case setting = "設定"
}

struct ContentView: View {
    @State private var selectedTab: TabState = .post
    @State private var canSwipe: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            TopTabView(selectedTab: $selectedTab)
            TabView(selection: $selectedTab,
                    content:  {
                Text(TabState.post.rawValue + "画面").tabItem { Text("このテキストは見えない") }.tag(TabState.post)
                SubView().tabItem { Text("このテキストは見えない") }.tag(TabState.save)
                SubTabView().tabItem { Text("このテキストは見えない") }.tag(TabState.setting)
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            //            // 初めてTabViewを表示
            //            SubTabView()
        }
    }

}

struct TopTabView: View {
    @Binding var selectedTab: TabState

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabState.allCases, id: \.self) { tab in
                Button(action: {
                    self.selectedTab = tab
                }, label: {
                    VStack(spacing: 0) {
                        HStack {
                            Text(tab.rawValue)
                                .font(Font.system(size: 18, weight: .semibold))
                                .foregroundColor(Color.primary)
                        }
                    }
                    .fixedSize()
                })
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .overlay(
                    Rectangle()
                        .frame(height: 3)
                        .foregroundStyle(selectedTab == tab ? Color.blue : Color.clear),
                    alignment: .bottom
                )
            }
        }
        .background(Color.white)
        .compositingGroup()
        .shadow(color: .primary.opacity(0.2), radius: 3, x: 4, y: 4)
    }
}

struct SubView: View {
    var body: some View {
        ZStack {
            Color.yellow
            Text("普通のサブビュー")
                .foregroundStyle(Color.black)
        }
    }
}

// 親がTabViewの場合は、このTabViewは表示されない
struct SubTabView: View {

    enum TabState2: String , CaseIterable{
        case post = "投稿2"
        case save = "保存2"
        case setting = "設定2"
    }

    @State private var selectedTab2: TabState2 = .post

    var body: some View {
        TabView(selection: $selectedTab2,
                content:  {
            Text(TabState2.post.rawValue + "画面").tabItem { Text(TabState2.post.rawValue) }.tag(TabState2.post)
            Text(TabState2.post.rawValue + "画面").tabItem { Text(TabState2.save.rawValue) }.tag(TabState2.post)
            Text(TabState2.post.rawValue + "画面").tabItem { Text(TabState2.setting.rawValue) }.tag(TabState2.post)
        })
        .tabViewStyle(.page)
    }
}


#Preview {
    ContentView()
}
