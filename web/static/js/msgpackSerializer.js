import msgpack from "msgpack-js-v5"

export default class MsgPackSerializer {

  contentType() { return "application/msgpack" }

  isBinary() { return true }

  binaryType() { return "arraybuffer" }  

  encode(payload) {
    return new Promise((resolve) => {
      resolve(msgpack.encode(payload))
    })
  }

  decode(payload) {
    console.log(payload)
    return new Promise((resolve) => {
      var fileReader = new FileReader()
      fileReader.onload = function(e) {
        let bytes = new Uint8Array(e.target.result.slice(0, e.target.result.byteLength))
        //console.log("about to decode message, that starts with", bytes);
        let msg = msgpack.decode(bytes)
        resolve(msg)
      }
      fileReader.readAsArrayBuffer(payload)
    })
  }
}
