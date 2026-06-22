# Ruby 從入門到專案實踐 - 程式碼清單

> **本書配套程式碼示例庫** — 從章節中提取的完整可運行程式碼

## 關於本書

Ruby 是一門誕生於 1995 年的動態程式語言，以「讓程式設計更快樂」為設計哲學。Ruby on Rails 框架開創了「約定優於配置」的 Web 開發範式，影響了全球數百萬開發者。本書採用《Python編程：從入門到實踐》驗證有效的「語言基礎 + 遞進專案」兩段式結構，讓零基礎讀者從第一行程式碼走到獨立做出可用的指令列工具、資料管理腳本、Web 應用。

本書采用"概念→程式碼→決策框架"的三段式結構：每個語法點先講清「是什麼」和「為什麼」，再給出可直接運行的完整程式碼，最後歸納使用場景與避坑指南。區別於市面常見的 API 列舉式教程，本書強調**系統性與決策判斷力**——學完這本書，你不只是知道 Ruby 會什麼，更能判斷在實際專案中何時用什麼、為什麼。

## 本書特點

**第一，版本最新，體系完整。** 全書鎖定 Ruby 3.3+（2025-2026 年穩定版），覆蓋從基礎語法到 Web 開發的完整知識圖譜。變量與常量、字串、陣列、哈希、控制流、函數、閉包、枚舉、類與物件、模組、MetaProgramming——每一個模組都配有從零到熟練的完整學習路徑。

**第二，決策框架驅動。** Ruby 語言的簡潔背後藏著許多「為什麼」。`var` vs `let`、`Symbol` vs `String`、`include` vs `extend`、塊與 Proc——本書不只是講語法，更講每種選擇的工程理由，讓讀者在真實專案中做出合理判斷。

**第三，程式碼即文檔。** 每個程式碼檔案都來自書中明確標號的程式碼清單（`程式碼清單 N-N`），可讀性優先於表演性。檔案名即包含章節號與內容摘要，可直接在對應章節回溯上下文。

**第四，專案驅動學習。** 七個遞進專案從指令列工具到 Web 應用再到雲端部署，讓讀者在實戰中鞏固語法知識，告別「學完就忘」的困境。

## 誰應該讀這本書

如果你希望系統建立 Ruby 語言基礎，並真正理解語言背後的設計哲學，這本書適合你。你可能是：

- 零程式設計基礎或僅有少量其他語言經驗的初學者；
- 想轉 Web 開發的求職者；
- 有其他語言背景（如 Python、JavaScript、Java）需要快速掌握 Ruby 的開發者；
- 在校學生與培訓機構學員，需要一份系統教程而非碎片化視頻；
- 正在學習《Ruby 官方文檔》但缺乏實戰語境指引的自學者。

## 程式碼清單說明

本目錄包含從書籍章節中提取的程式碼示例檔案，覆蓋全書核心知識點的完整可運行示例。

### 📊 程式碼統計

- **總檔案數**: 535 個
- **Ruby 檔案**: 424 個
- **Bash 檔案**: 64 個
- **其他**: 55 個（JSON、HTML、ERB、CSS、YAML、Nginx 配置等）
- **涉及章節**: 第 1—41 章

### 📋 按檔案類型分類

| 類型       | 檔案數 | 說明                                              |
| ---------- | ------ | ------------------------------------------------- |
| Ruby      | 424    | 完整可運行的 `.rb` 程式碼檔案                    |
| Bash      | 64     | 終端命令、部署腳本、GitHub Actions 配置          |
| YAML      | 5      | CI/CD 配置                                        |
| ERB       | 26     | Sinatra/Rails 視圖模板                          |
| JSON      | 9      | 資料模型、工廠配置                               |
| HTML      | 4      | 視圖模板                                         |
| 其他       | 11     | CSS、Nginx 配置、HTTP 協定說明等                  |

### 📂 章節覆蓋

- **第 1—4 章**：開發環境、變量與常量、字串、運算子與表達式
- **第 5—6 章**：陣列、哈希
- **第 7—8 章**：條件判斷、循環與迭代
- **第 9—11 章**：函數、塊(Block)、Proc 與 Lambda、符號與枚舉
- **第 12—14 章**：正則表達式、檔案操作與 IO、錯誤處理
- **第 15—20 章**：類與物件、繼承與模組、Mixin 與組合、MetaProgramming、單元測試、Gem 與包管理
- **第 21—41 章**：七個遞進專案（Todo CLI / 猜數字 / 聯繫人管理 / Sinatra 部落格 / Rails 社交 / 電商 API / 阿里雲部署），含全書總結

## 如何使用程式碼

### 環境準備

- **Ruby**: 3.3+（推薦使用 [ruby-lang.org](https://www.ruby-lang.org) 安裝或通過 RVM/Rbenv）
- **Rails**: 7.x-8.x（本書專案五、六、七使用）
- **Sinatra**: 4.x（本書專案四使用）
- **編輯器**: Visual Studio Code（安裝 Ruby 擴展）或 RubyMine
- **瀏覽器**: 用於查閱 Ruby 官方文檔 [docs.ruby-lang.org](https://docs.ruby-lang.org)

### 檔案命名規範

程式碼清單使用兩種命名格式并存：

```text
chapter{章節號:03d}_code{序號}.{擴展名}
代碼清單{章節號}-{序號}[（變體）].{擴展名}
```

示例：

- `chapter007_code1.rb` — 第 7 章第 1 個 Ruby 程式碼片段
- `chapter012-regexp.rb` — 第 12 章正則表達式完整示例
- `代碼清單21-1_ TodoCLI需求拆解.md` — 第 21 章程式碼清單 1

### 運行示例

**單檔案 Ruby 示例**：

```bash
ruby src/chapter010.rb
```

**IRB 互動式學習**：

```bash
irb
irb(main):001> load 'src/chapter010.rb'
```

**完整專案運行**：

```bash
# 進入專案目錄
cd ruby-book/src/project21-todo-cli

# 安裝依賴
bundle install

# 運行
ruby todo.rb
```

## 配套資源

- **GitHub 倉庫**: [https://github.com/zcqiand/ruby-book](https://github.com/zcqiand/ruby-book)
- **勘誤頁面**: [https://github.com/zcqiand/ruby-book/issues](https://github.com/zcqiand/ruby-book/issues)
- **讀者交流**: 1282301776@qq.com
- **姊妹篇（Vue）**: [https://github.com/zcqiand/vue-book](https://github.com/zcqiand/vue-book)（Vue 從入門到專案實踐）
- **姊妹篇（React）**: [https://github.com/zcqiand/react-book](https://github.com/zcqiand/react-book)（React 從入門到專案實踐）
- **姊妹篇（Swift）**: [https://github.com/zcqiand/swift-book](https://github.com/zcqiand/swift-book)（Swift 從入門到專案實踐）

## ⚠️ 注意事項

1. **程式碼版本**: 程式碼基於 Ruby 3.3+（2025-2026 年基線）編寫，運行前請確保本地 Ruby 版本為 3.3 或更高
2. **依賴管理**: 部分專案需要安裝 Gem 依賴，請先運行 `bundle install`
3. **資料庫**: Rails 專案使用 PostgreSQL，請確保本地已安裝並運行
4. **跨平台**: Ruby 程式碼本身跨平台，但涉及特定平台 API 時請注意目標平台兼容性
5. **章節連續性**: 本書程式碼清單按章節編號排列，部分章節（如第 4 章）無程式碼清單屬於正常情況（純概念章節）

---

**最後更新**: 2026 年 6 月
**書籍版本**: 1.0
**程式碼來源**: [../chapters](../chapters/)
