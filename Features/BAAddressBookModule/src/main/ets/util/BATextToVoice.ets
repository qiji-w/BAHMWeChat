import { textToSpeech } from '@kit.CoreSpeechKit'
import { util } from '@kit.ArkTS'

export class BATextToVoice {
  static ttsEngine: textToSpeech.TextToSpeechEngine
  static voiceInitParamsInfo: textToSpeech.CreateEngineParams = {
    language: 'zh-CN',
    person: 0,
    online: 1,
    extraParams: {}
  }
  static speakParams: textToSpeech.SpeakParams = {
    requestId: util.generateRandomUUID(),
    extraParams: {
      "speed": 1,
      "volume": 1,
      "pitch": 1,
      "languageContext": 'zh-CN',
      "audioType": "pcm"
    }
  }

  static async start(text: string) {
    if (!BATextToVoice.ttsEngine) {
      BATextToVoice.ttsEngine = await textToSpeech.createEngine(BATextToVoice.voiceInitParamsInfo)
    }
    BATextToVoice.ttsEngine.speak(text, BATextToVoice.speakParams)
  }
}