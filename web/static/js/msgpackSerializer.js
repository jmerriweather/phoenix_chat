import msgpack from "msgpack-js-v5"

export default class MsgPackSerializer {

  encode(payload, callback) {
    callback(msgpack.encode(payload))
  }

  decode(payload, callback) {
    var fileReader = new FileReader()
    fileReader.onload = function(e) {
      let bytes = new Uint8Array(e.target.result.slice(0, e.target.result.byteLength))
      //console.log("about to decode message, that starts with", bytes);
      let msg = msgpack.decode(bytes)        
      callback(msg)
    }
    fileReader.readAsArrayBuffer(payload)
  }
}
