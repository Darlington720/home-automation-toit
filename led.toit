import gpio
import net
import mqtt
import encoding.json


LED ::= 5
HOST ::= "192.168.42.28"
topic ::= "test/topic/led1"
CLIENT_ID ::= "Esp32"

main:
    led ::= gpio.Pin LED --output
    transport := mqtt.TcpTransport net.open --host=HOST

    client := mqtt.Client --transport=transport
    client.start --client_id="$CLIENT_ID-no-routes"
        --on_error=:: print "Client error: $it"

    client.publish "$topic" "Connected to led for testing".to_byte_array --qos=0
        

    client.subscribe "$topic":: | topic payload |
        // if (payload.to_string_non_throwing == "on"): 
        //     led.set 1
        //     client.publish "$topic" "on".to_byte_array --qos=0
        // else if (payload.to_string_non_throwing == "off"):
        //     led.set 0
        //     client.publish "$topic" "off".to_byte_array --qos=0

        print "Message received: $topic - message: $payload.to_string_non_throwing"