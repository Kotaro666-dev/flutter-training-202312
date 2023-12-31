# アーキテクチャ

## 概要

レイヤードアーキテクチャを採用しています。

![アーキテクチャ図](./architecture.png)

## 各レイヤー

### Presentation

プレゼンテーション層は、UIに関連する処理およびユーザーの入力を受け付ける責務を担う。
以下のように、各画面ごとのディレクトリで構成される。

- components: 画面のコンポーネントが集約されている
- providers: 画面で使用する状態オブジェクトやドメイン層のビジネスロジックと連携し処理を行う

### Domain

ドメイン層は、ビジネスロジックの責務を担う。
以下のディレクトリで構成される。

- models: ドメインモデルが定義されている
- providers: 依存性注入の定義が集約されている
- repositories: データ層で定義されたリポジトリの抽象化されたインターフェスが集約されている
- usecases: 核となるビジネスロジックが集約されている

### Data

データ層は、サーバーサイドやローカルDBとの通信やデータ管理ロジックの責務を担う。
以下のディレクトリで構成される。

- datasources
  - remote: APIを利用してHTTPリクエストを行う処理の責務を担う
  - local: データをキャッシュしたり永続化する処理の責務を担う
- models: データモデルが定義されている
- repositories: ドメイン層で定義されたリポジトリの詳細実装が集約されている。異なるデータソースからデータを調整する責務を担う
- providers: 依存性注入の定義が集約されている

