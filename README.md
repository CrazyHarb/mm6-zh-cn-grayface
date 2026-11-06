# 魔法门6：简体中文 + GrayFace 键位/鼠标视角兼容包

本仓库是面向《魔法门6：天堂之令》的本地交付工程。它在玩家已有的完整简体中文安装上，整合 GrayFace 2.5.7、MMExtension、DBCS 中文渲染、WASD 平移、视口中心鼠标锁定、方向键飞行、控制台指令和副本加载崩溃修复。

本目录是本地创建并维护的 Git 交付仓库，远端为 `git@github.com:CrazyHarb/mm6-zh-cn-grayface.git`。

## 1. 适用范围与边界

- 适用于已经包含完整简体中文 `icons.lod` 和 `games.lod` 的 MM6 安装，例如当前这套 GOG 中文资源安装。
- 保留原有中文文本、中文语音、动画和存档。
- 不包含游戏本体、完整动画、完整音乐或完整中文 LOD。
- **不能把本包当成纯英文全新安装的独立汉化包。**纯英文安装缺少本包所保留的完整中文文本和事件脚本。
- 不使用魔法门678整合版，不合并或替换两个不同补丁的 `mm6.exe`。

## 2. 上游工程与素材来源

| 来源 | 本包中的用途 | 修改/整合/复制方式 |
|---|---|---|
| [might-and-magic/mm678-i18n](https://github.com/might-and-magic/mm678-i18n) | DBCS 字体、编码配置、中文渲染与构建工具 | 使用 `mm678-i18n-master` 源码快照并进行本地修改；保留其 MIT 许可说明 |
| [GrayFace/Misc](https://github.com/GrayFace/Misc) | GrayFace MM6 Patch 2.5.7、键位、鼠标视角、图形资源和补丁参考 | 使用 `Misc-master` 源码快照，整合必要的 EXE、DLL、LOD 和说明文件；无 `.git` |
| [GrayFace/MMExtension](https://github.com/GrayFace/MMExtension) | Lua 控制台、原生结构体、事件、内存与调试接口 | 运行库和脚本随兼容包整合，没有单独的上游仓库工作副本 |
| [might-and-magic/mm6chup](https://github.com/might-and-magic/mm6chup) | 中文资源、历史修复和兼容性参考 | 使用 `mm6chup-master` 源码快照作为参考；不复制其 `mm6.exe`，不运行旧安装器 |
| [might-and-magic/mm6chupchangekey](https://github.com/might-and-magic/mm6chupchangekey) | 原版动作和键位资料 | 使用 `mm6chupchangekey-master` 源码快照作为参考；不执行固定偏移键位修改工具 |
| [GrayFace/fnt-generator](https://github.com/GrayFace/fnt-generator) | BDF 字体生成与检查 | 使用 `fnt-generator-master` 源码快照作为工具；无 `.git` |
| [OpenEnroth/OpenEnroth](https://github.com/OpenEnroth/OpenEnroth) | 原版 UI、动作和地图行为的逆向参考 | 仅核对资料，不复制或合并其引擎代码 |
| 玩家已有的中文 MM6 安装 | 完整中文文本、事件脚本、语音、动画和存档 | 原样保留；禁用会重新覆盖英文内容的 LOD 文件 |

这些目录均为源码快照或本地工作目录，文档没有为它们虚构 clone 历史、远端地址或上游提交号。

### 本仓库原创修改

- `payload/Scripts/General/MM6Cheats.lua`：本仓库编写的控制台指令，并非上游作弊脚本复制件。
- `payload/Scripts/General/FixDecListCount.lua`：根据 `D:\crash.dmp` 的原生异常栈编写的副本计数兼容修复。
- `payload/Scripts/General/FlightControls.lua`：直接处理方向键和滚轮事件，修复飞行术后的起飞、上升和降落。
- `payload/MM6.ini`：WASD、攻击/施法、飞行和其他 GrayFace 键位的本地配置。
- `install.bat`：备份、禁用英文覆盖资源并复制 payload 的安装器。
- `使用说明.txt`、`COMPAT-NOTES.md`、`BUILD-INFO.txt` 和本 README。

## 3. 安装

1. 将整个 `MM6_zh_CN_GrayFace` 目录解压到任意位置。
2. 运行 `install.bat`，或执行：

   ```bat
   install.bat "D:\gog\GOG Galaxy\Games\Might and Magic 6"
   ```

3. 不带参数时，安装器会提示输入游戏目录。
4. 如果提示权限不足，请用管理员身份运行。
5. 启动游戏目录中的 `MM6.exe`。首次启动如生成 MMExtension 数据表，请等待完成。

安装器先把关键文件备份到：

```text
游戏目录\Backup-MM6-Compatibility
```

备份包括 `MM6.exe`、配置、补丁 DLL、中文 `icons.lod`、`games.lod` 和 `Sounds\Audio.snd` 等。安装器随后把 `payload` 复制到游戏目录，并将以下英文覆盖文件改名为 `.disabled`：

- `00 patch.icons.lod`
- `10 LocZHCN.icons.lod`
- `00 patch.games.lod`

保留的完整中文 `icons.lod` 和 `games.lod` 已包含中文文本、事件脚本及旧版地图修复，因此不再用英文地图/事件覆盖它们。

## 4. 默认操作

| 按键 | 功能 |
|---|---|
| W / S | 前进、后退 |
| A / D | 左右平移，不是转身 |
| 鼠标 | 转动、仰视、俯视；锁定在 3D 视口中心 |
| CapsLock / 鼠标中键 | 开关鼠标视角 |
| Q | 武器攻击 |
| E | 施展备用魔法 |
| F | 跳跃 |
| ↑ | 起飞、上升 |
| ↓ | 降落 |
| V | 降落 |
| X | 任务 |
| 滚轮 | 向上/向下飞 |
| F2 | 双倍速 |
| F3 | 自动前进 |
| F5 | 快速保存 |
| F8 | 快速读取 |

“视口中心”是实际 3D 画面区域的中心，不是窗口外框中心。进入背包、对话等界面时，鼠标按原游戏规则释放。

`FlightControls.lua` 在户外且飞行术有效时直接设置原生 `Flying`、`InAir`、`FlyingBit` 和 `SpeedZ`，不依赖 PageUp 的旧条件分支。↑/滚轮向上用于起飞和上升，滚轮向下用于下降，↓ 调用原生命令 15 降落。

## 5. 控制台指令

在游戏中按 **Ctrl+F1**，输入指令后按 **Ctrl+Enter**。若控制台不接收字符，先切换英文键盘。

| 指令 | 功能 |
|---|---|
| `god()` | 开关无限血量：正常伤害归零并持续补满全队 HP；不复活、不清异常 |
| `mana()` | 开关无限魔法值：持续补满全队 SP |
| `nocd()` | 开关攻击无冷却：清除恢复延迟，近战/远程攻击延迟归零 |
| `buff()` | 补齐全部 23 项有益 Buff，持续 24 小时游戏时间，可重复刷新 |
| `learn()` | 人物 255 级、全部 31 项技能大师、全部 100 个法术；经验清零 |
| `immune()` | 开关负面状态免疫：开启时清除并持续阻止全部 17 类 Condition |

补充规则：

- `god()`、`mana()`、`nocd()`、`immune()` 的状态仅在当前进程内有效，重启后默认关闭。
- `buff()` 直接写原生 Buff 记录：大师级，复合增益 `Power=40`，单项增益 `Power=10`，不消耗 SP。
- 满 Buff 保留原生副作用：Haste 消失后会 Weak，Guardian Angel 触发时消耗一半携带金币；飞行和水上行走仍有场景限制。
- `learn()` 覆盖武器、防具、九系魔法、经商、学习等全部技能，绕过职业和训练限制；经验清零以避免继续升到 256。
- `immune()` 只处理 Condition，不恢复 HP；死亡状态可配合 `god()` 使用。

## 6. 副本加载崩溃修复

`payload/Scripts/General/FixDecListCount.lua` 处理一种已用 dump 确认的崩溃：

- 异常地址：`MM6+0xAF390`，位于字符串比较函数。
- 调用位置：`MM6+0x456980`，正在查找 `Event Trigger` 装饰物。
- 根因：环境标志写入 `DecListBin.Count` 高 16 位，使正常数量被解释为异常大值并越界遍历。

修复会在两个原生装饰物查找循环及进图前后规范化高半字，保留低 16 位真实数量，不修改地图或存档。验证时每次进图前强制把高半字设为 1，连续进入 `t1.blv` 和 `t2.blv`，最终计数均为正常的 230，`failures=0`。

## 7. 目录结构

```text
MM6_zh_CN_GrayFace/
├─ README.md                 本文件：来源、功能、安装、验证与边界
├─ 使用说明.txt               玩家使用说明
├─ COMPAT-NOTES.md           中文资源覆盖与副本修复取舍
├─ BUILD-INFO.txt            构建来源和实际验证记录
├─ install.bat               备份、禁用覆盖资源并安装 payload
└─ payload/
   ├─ MM6.exe                GrayFace 2.5.7 的 MM6 可执行文件
   ├─ MM6patch.dll           GrayFace 补丁 DLL
   ├─ MM6.ini                键位、鼠标和启动配置
   ├─ mm6lang.ini            中文界面与快速存档名称
   ├─ Data/                  DBCS 字体、配置和图形资源
   ├─ Scripts/
   │  ├─ Core/               MMExtension 核心脚本
   │  ├─ Structs/            原生结构体与扩展
   │  └─ General/
   │     ├─ FNT_DBCS.lua      中文 DBCS 渲染与字体引导
   │     ├─ MM6Cheats.lua     六个控制台指令
   │     ├─ FlightControls.lua  方向键/滚轮飞行控制
   │     └─ FixDecListCount.lua 副本计数崩溃修复
   └─ ExeMods/               MMExtension 运行组件
```

## 8. 验证记录

已执行并在 `BUILD-INFO.txt` 中记录：

- 130 项 DBCS 离线检查通过。
- 45 项项目单元测试通过。
- 中文装载界面、游戏内文本和换行验证通过。
- WASD 平移、鼠标转向和视口中心锁定通过。
- 四个初始控制台指令在真实 3D 场景中完成 151 项断言，`failures=0`。
- `learn()` 与 `immune()` 在实际进程中完成 624 项断言，`failures=0`。
- 四名角色均为 255 级、31 项技能大师、100 个法术，原生 `CanTrain` 禁止继续训练，HP 计算正常。
- 全部 17 类 Condition 的立即清除、持续免疫及关闭恢复通过。
- 强制装饰物高半字异常后连续进入两个地下城，计数均为 230。
- Key33 被接受为上升动作，Key36 成功将 `Party.Flying` 从 `true` 变为 `false`。
- 直接注入 ↑、滚轮上/下和 ↓ 的 MMExtension 事件，飞行状态、垂直速度、松开停止及降落全部通过，`failures=0`。

测试用自动新游戏、动作队列、临时角色修改和验证脚本不进入安装包；测试改写的 `autosave.mm6` 已从备份恢复。

## 9. 源码、重建与恢复

本机源码快照位于 `D:\键位`：

- `Misc-master`：GrayFace 官方补丁与工具。
- `mm6chup-master`、`mm6chupchangekey-master`：中文补丁和旧键位工具参考。
- `mm678-i18n-master`：翻译、DBCS 渲染器及本地修改。
- `fnt-generator-master`：字体工具。

中文文件重建命令：

```bat
python -m mm678i18n build --no-release --langs zh_CN --jobs 1
```

重新安装时再次运行 `install.bat` 即可。需要恢复旧版本时，从 `Backup-MM6-Compatibility` 将对应文件复制回游戏目录。

## 10. 许可与版权

- 各上游组件仍按各自项目许可证处理；本 README 不构成对游戏资源或上游组件的统一再授权。
- MM678 I18N 代码见上游 MIT 许可；GrayFace 补丁和工具见其项目许可。
- 《魔法门6》及相关游戏内容归原权利人。本包不包含完整游戏、完整中文 LOD、完整动画或完整音乐。
- 不要再运行旧的 `tosimp_installer\INSTALL.bat` 或 `mm6chupchangekey.exe`，否则会覆盖 GrayFace 的可执行文件和当前键位表。
