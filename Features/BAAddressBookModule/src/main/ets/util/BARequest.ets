import { http } from '@kit.NetworkKit'
import { BAChatResult } from '../viewmodel/BAChatViewModel'

const req = http.createHttp()

export async function requestMessage(content: string) {
  try {
    const res = await req.request(`https://api.ownthink.com/bot?userid=${Date.now()}&spoken=${content}`)
    const result = JSON.parse(res.result as string) as BAChatResult
    return result
  } catch (err) {
      return Promise.reject(err)
  }
}