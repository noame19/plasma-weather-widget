# plasma-weather-widget

KDE Plasma 6 weather widget powered by Open-Meteo.

## 改动 / Changes

相比上游 repo，做了 3 处主要改动：

Three main changes were made on top of the upstream fork:

### 1. 新增气压和降雨量参数
在 popup 的「风速 / 湿度」一行中加入了 **大气压**（hPa）和**最近1 小时降雨量**（mm）。

Adds **atmospheric pressure** (hPa) and **precipitation** (mm) to the wind/humidity row of the popup.

### 2. 新增未来6 小时天气预报
在 daily forecast 上面加了一行 6 小时预报（hour label + 动画图标 + 温度 + 降水概率）。

Adds a **next-6-hours forecast** row above the 5-day daily forecast.

### 3. 动画天气图标垂直对齐
`AnimatedWeatherIcon.qml` 加了按 weather code 的 `verticalCenterOffset`。
让横向并排的列里每个图标的视觉重心落在同一水平线上。

`AnimatedWeatherIcon.qml` now applies a per-weather-code `verticalCenterOffset`.
All icons in a horizontal row now share the same visual centerline.
