import zmq

conteudo = zmq.Context()

#  Socket para se comunicar com o servidor
print("Conectando com o servidor MQL...")
socket = conteudo.socket(zmq.REQ)
socket.connect("tcp://192.168.1.4:5555")

# Um lopp infinito para atualizar o Robo expert
while (True):
    socket.send("fibonacci")
    arquivo = open('fibonacci.txt','w')
    
    #  Recebendo uma mensagem
    mensagem = socket.recv()
    print("Resposta do servidor: %s " % (mensagem))
    arquivo.write(mensagem)
    arquivo.close()


