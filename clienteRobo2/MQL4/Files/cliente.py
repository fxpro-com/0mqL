import zmq

context = zmq.Context()

print("Conectando com o servidor...")
socket = context.socket(zmq.REQ)
socket.connect("tcp://192.168.1.18:5555")

for request in range(10):
    print("Requisicao %s ..." % request)
    socket.send("robo1")

    messagemRecebida = socket.recv()
    print("Mensagem recebida %s [ %s ]" % (request, messagemRecebida))
