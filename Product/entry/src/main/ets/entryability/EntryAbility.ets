import { abilityAccessCtrl, AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { KeyboardAvoidMode, window } from '@kit.ArkUI';
import { DynamicsRouter } from '@ohos/dynamicsrouter';
import { BAAVPlayerClass,BAStoreClass } from '@ohos/baaddressbookmodule'

export default class EntryAbility extends UIAbility {
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');

    DynamicsRouter.routerInit({
      libPrefix: "@ohos", mapPath: "routerMap"
    }, this.context)

    // 绑定上下文信息
    AppStorage.setOrCreate('context', this.context)
    // 事件订阅(获取上次异常退出信息)
    // eventSubscription();

    const manager = abilityAccessCtrl.createAtManager()
    await manager.requestPermissionsFromUser(this.context, [
      "ohos.permission.MICROPHONE",
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION"
    ])
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    // 在这里getContext没用
    BAStoreClass.init(this.context)
    // 初始化音乐播放器
    BAAVPlayerClass.init(this.context)

    windowStage.loadContent('pages/EntryView', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });

    AppStorage.setOrCreate('windowStage', windowStage);
    hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
