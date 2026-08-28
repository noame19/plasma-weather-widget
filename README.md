# plasma-weather-widget

KDE Plasma 6 weather widget powered by Open-Meteo.

## 改动 / Changes

相比上游 fork，本仓库在 `com.github.weather-widget/` 上做了 3 处主要改动：

Three main changes were made on top of the upstream fork:

### 1. 新增气压和降雨量参数
在 popup 的「风速 / 湿度」一行中加入了 **大气压**（hPa）和**最近1 小时降雨量**（mm）。
两个参数都用 logo + 数值的形式，图标是自绘的 `BarometerIcon.qml` / `RaindropIcon.qml`（QML Canvas），不依赖系统图标主题。

Adds **atmospheric pressure** (hPa) and **precipitation** (mm) to the wind/humidity row of the popup.
Icons are custom `BarometerIcon.qml` / `RaindropIcon.qml` (QML Canvas) — no icon-theme dependency.

### 2. 新增未来6 小时天气预报
在 daily forecast 上面加了一行 6 小时预报（hour label + 动画图标 + 温度 + 降水概率）。
复用 daily 的 ColumnLayout delegate。

Adds a **next-6-hours forecast** row above the 5-day daily forecast, reusing the same ColumnLayout delegate pattern.

### 3. 动画天气图标垂直对齐
`AnimatedWeatherIcon.qml` 加了按 weather code 的 `verticalCenterOffset`（多云上移8%，阴天上移6%，雾下移2%，雨/雪/雷下移22%），并加 `clip:true` 防止雨滴/雪花溢出。
让横向并排的列里每个图标的视觉重心落在同一水平线上。

`AnimatedWeatherIcon.qml` now applies a per-weather-code `verticalCenterOffset` (partly cloudy -8%, overcast -6%, fog +2%, rain/snow/storm +22%) and `clip:true` to prevent drop/snowflake overflow.
All icons in a horizontal row now share the same visual centerline.
