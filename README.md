# kmp-sample-ios

Kotlin Multiplatform で作成された火星の不動産情報を表示する iOS アプリケーションです。

本プロジェクトは [kmp-sample-library](https://github.com/kei-1111/kmp-sample-library) で実装された状態管理（ViewModel、Repository、データ層など）を使用し、**iOS 側では UI 実装のみ**を行っています。これにより、ビジネスロジックとプラットフォーム固有の UI 実装を明確に分離しています。

## スクリーンショット

<!-- スクリーンショットをここに追加 -->


## アーキテクチャ

```
┌─────────────────────────────────────┐
│         kmp-sample-ios              │
│     (UI Layer - iOS Only)           │
│                                     │
│  ┌──────────┐    ┌───────────────┐ │
│  │   App    │────│   HomeScreen  │ │
│  └──────────┘    │   (UI)        │ │
│                  └───────────────┘ │
│                         │          │
└─────────────────────────┼──────────┘
                          │
                          ▼
┌─────────────────────────────────────┐
│      kmp-sample-library (KMP)       │
│                                     │
│  ┌──────────────────────────────┐  │
│  │ ViewModel / Repository       │  │
│  │ State Management             │  │
│  │ Business Logic               │  │
│  │ Data Layer                   │  │
│  └──────────────────────────────┘  │
└─────────────────────────────────────┘
```

## 技術スタック

### UI 実装
- **SwiftUI** - モダンな宣言的 UI フレームワーク
- **AsyncImage** - 画像読み込み

### 状態管理（kmp-sample-library より提供）
- **ViewModel** - UI 状態の管理
- **Repository パターン** - データ操作の抽象化
- **Koin** - 依存性注入

### パッケージ管理
- **Swift Package Manager** - 依存関係管理

## プロジェクト構成

```
kmp-sample-ios/
├── KmpSampleIOS/
│   ├── KmpSampleIOSApp.swift      # アプリケーションのエントリポイント
│   ├── Screen/
│   │   └── HomeScreen.swift       # ホーム画面の UI 実装
│   ├── ViewModelWrapper/
│   │   └── HomeViewModelWrapper.swift  # ViewModel のラッパー
│   ├── Components/
│   │   ├── MarsPropertyCardView.swift  # 不動産カードコンポーネント
│   │   └── MarsPropertyDetailBottomSheet.swift  # 詳細表示ボトムシート
│   └── Utils/
│       └── Koin.swift             # Koin 初期化ユーティリティ
├── KmpSampleIOSTests/             # ユニットテスト
└── KmpSampleIOSUITests/           # UI テスト
```

### 各コンポーネントの役割

- **KmpSampleIOSApp**: アプリケーションのエントリポイント。Koin の初期化を行います。
- **HomeScreen**: 火星の不動産情報を表示するホーム画面の UI を実装します。ViewModel や状態管理は `kmp-sample-library` から提供されます。
- **HomeViewModelWrapper**: KMP の ViewModel を SwiftUI で使用するためのラッパークラスです。
- **Components**: 再利用可能な UI コンポーネントを提供します。

## セットアップ

### 前提条件

- macOS 14.0 以上
- Xcode 16.0 以上
- iOS 18.5 以上
- Swift 5.0 以上

### GitHub Packages の設定

本プロジェクトは Swift Package Manager を使用して GitHub Packages から `kmp-sample-library` を取得します。プライベートリポジトリの場合、以下の設定が必要です。

1. GitHub Personal Access Token を作成（`read:packages` 権限が必要）
2. Xcode の設定で GitHub アカウントを追加：
   - Xcode > Settings > Accounts
   - 左下の + ボタンをクリックして GitHub アカウントを追加
   - Personal Access Token を使用してログイン

### ビルド手順

```bash
# リポジトリのクローン
git clone https://github.com/kei-1111/kmp-sample-ios.git
cd kmp-sample-ios

# Xcode でプロジェクトを開く
open KmpSampleIOS.xcodeproj

# Xcode でビルド・実行
# または Command + R でシミュレータ/実機で実行
```

## 機能

- 火星の不動産情報一覧表示（グリッドレイアウト）
- 不動産詳細情報の表示（Bottom Sheet）
- 画像の非同期読み込み
- 状態管理（読み込み中、エラー表示など）

## 関連リポジトリ

- [kmp-sample-library](https://github.com/kei-1111/kmp-sample-library) - ビジネスロジックと状態管理を提供する Kotlin Multiplatform ライブラリ
- [kmp-sample-android](https://github.com/kei-1111/kmp-sample-android) - Android 版アプリケーション
